# RPCA-MKL
RPCA-MKL is a Intel MKL-based, out-of-core C++ implementation of randomized SVD for rank-k approximation of large matrices. It is primarily intended to be used via an R wrapper.   

## R Package Installation

1. If you don't have it already, install devtools: `install.packages('devtools')`
2. Install fastRPCA: `devtools::install_github("KlugerLab/rpca-mkl",subdir="fastRPCA")`

Or, if you do not want to install devtools,
1.  Clone this git repository
2. `cd fastRPCA`
3. `R CMD INSTALL .`

Please see the documentation for usage: `?fastPCA` 

Note: The pre-compiled MKL libraries are only included for Linux and OS X, so this installation will not work for Windows. Windows users can see Development for details about compling the code. 

## R Testing Suite
Test the code by running the following:

`source(sprintf("%s/test.R", system.file("tests", package="fastRPCA")))`


## Features
* All matrix algebra is done with Intel MKL (pre-compiled version already linked) making it extremely fast
* Row-centering and column-centering (without duplicating the matrix)
* The calculations are 'blocked' allowing it to be 'out-of-core'. This functionality has not been tested appropriately; please see [oocRPCA]( https://github.com/klugerlab/oocpca ) for a functioning version.
  * CSV files: when too large for the memory, read block by block from the hard drive
  * BED files: when too large for the memory, stored in a compressed 2 bit-per-SNP format, and then decompressed block by block for calculations


## Compiling from source
This packages uses Intel Math Kernel Library, which has highly optimized implementations of BLAS and LAPACK (Free download [here](https://software.intel.com/sites/campaigns/nest/) ).  The `lib` folder contains a [custom built shared library](https://software.intel.com/en-us/node/528690), but the headers cannot be distributed.  As such, to compile from source, Intel MKL must be installed on your machine.

1. Update the `MKL_INCLUDE` path in the Makefile. Make sure the compiler in the `CC` variable is openmp compatible.  On OS X, for example, you can use homebrew to install libiomp5 for Clang/LLVM. Just be sure that it is the compiler being used.
2. Run  `make` in the `src` folder.
3. You may need to export the `LD_LIBRARY_PATH` or (on OS X)  `DYLD_LIBRARY_PATH` so that the new executable can find the necessary dynamic libraries in the `lib` folder. For example: ` export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/user/Downloads/fastPCA/lib"`. 
