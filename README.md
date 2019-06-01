# RPCA-MKL
RPCA-MKL is a Intel MKL-based, out-of-core C++ implementation of randomized SVD for rank-k approximation of large matrices.  It is primarily intended to be used via an R wrapper, but can also be called by command-line. The code also supports out-of-core usage; that is, PCA of matrices that cannot be loaded in the memory, but this functionality is still in beta. 

## R Package Installation

1. Install devtools: `install.packages('devtools')`
2. Install fastRPCA: `devtools::install_github("linqiaozhi/rpca-mkl",subdir="fastRPCA")`

Or, if you do not want to install devtools,
1.  Clone this git repository
2. `cd fastRPCA`
3. `R CMD INSTALL .`

Please see the documentation for usage: `?fastPCA ?fastPCA_CSV  ?fastPCA_BED `

Note: The pre-compiled MKL libraries are only included for Linux and OS X, so this installation will not work for Windows. Windows users can see Development for details about compling the code. 

## R Testing Suite
Test cases for this software use the popular testing package `testthat`:

1. `install.packages('testthat')`
2. `testthat::test_dir(sprintf("%s/testthat", system.file("tests", package="fastRPCA")))`

## Installing Command-line Implementation
1. Clone this git repository
2. Export the `LD_LIBRARY_PATH` or (on OS X)  `DYLD_LIBRARY_PATH` so that the new executable can find the
   necessary dynamic libraries in the `lib` folder.  ` export
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/user/Downloads/fastPCA/lib"`. 

## Features
* Variety of input formats and use cases
  * From memory in R
  * CSV format
  * plink's binary [BED format] (http://pngu.mgh.harvard.edu/~purcell/plink/binary.shtml) for GWAS data. 
* All matrix algebra is done with Intel MKL (pre-compiled version already linked) making it extremely fast
* The calculations are 'blocked' allowing it to be 'out-of-core' when necessary, so that the user to specify the maximum amount of memory to be used.
  * CSV files: when too large for the memory, read block by block from the hard drive
  * BED files: when too large for the memory, stored in a compressed 2 bit-per-SNP format, and then decompressed block by block for calculations
* Row-centering and column-centering
* Imputation by averaging of missing data for GWAS


## Compiling from source
This packages uses Intel Math Kernel Library, which has highly optimized implementations of BLAS and LAPACK (Free download [here](https://software.intel.com/sites/campaigns/nest/) ).  The `lib` folder contains a [custom built shared library](https://software.intel.com/en-us/node/528690), but the headers cannot be distributed.  As such, to compile from source, Intel MKL must be installed on your machine.

1. Use a terminal to cd into the src folder, and run the command `make` which will build the software in that folder.
2. Export the `LD_LIBRARY_PATH` or (on OS X)  `DYLD_LIBRARY_PATH` so that the new executable can find the
   necessary dynamic libraries in the `lib` folder. For example:
  ` export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/user/Downloads/fastPCA/lib"`. 
