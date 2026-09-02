# See also
# https://github.com/gemini3d/gemini3d/blob/main/docs/Readme_VEGA.md

# you can pick whatever directory name you like
BUILDDIR=./build

# LAPACK_ROOT is the path above the Lapack library.
# for example if there's /scratch/share/ECLAIR/lib/lapack/lib/liblapack.so
export LAPACK_ROOT=/scratch/share/ECLAIR/lib/lapack

# The HPC needs these to setup the compiler environment
source /home2/appman/spack/share/spack/setup-env.sh
source $(spack location -i lmod)/lmod/lmod/init/bash
module use /home2/appman/spack/share/spack/modules/linux-rocky8-zen4
module purge
module load cmake
module load openmpi/5.0.2-gcc-13.2.0-4pbtkdf
module load gcc/13.2.0-gcc-8.5.0-265z6do
module load hdf5/1.14.3-gcc-13.2.0-i3idweh

# if you're just starting out, get a fresh start with a clean build directory.
# you don't need to do this often, because a key advantage of CMake/Make
# is the ability to rebuild only the files necessary after you've saved changes.
rm -rvf $BUILDDIR

# gemini3d_hwm14 is a CMake cache variable, setting it to "yes" or "true" or "1"
# tells Gemini3D to incorporate HWM14 model, which is "off" by default

cmake -B $BUILDDIR -Dgemini3d_hwm14=yes

# using 32 threads to build code - it's fast!
# use this command after saving your changes to get a fresh Gemini3D programs and libraries.
cmake --build $BUILDDIR -j32
