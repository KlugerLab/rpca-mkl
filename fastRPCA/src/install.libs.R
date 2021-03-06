# From http://conjugateprior.org/2015/06/identifying-the-os-from-r/
get_os <- function(){
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin')
      os <- "osx"
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  tolower(os)
}

if (get_os() == 'osx') {
    system(sprintf("install_name_tool -add_rpath %s  ../inst/libs/libfastpca.dylib",system.file("libs", package="fastRPCA") ))
    system(sprintf("install_name_tool -add_rpath %s  ../src/fastRPCA.so",system.file("libs", package="fastRPCA") ))
    system(sprintf("install_name_tool -change ../fastRPCA/inst/libs/libfastpca.dylib @rpath/libfastpca.dylib ../src/fastRPCA.so",system.file("libs", package="fastRPCA") ))
    #print(sprintf("install_name_tool -change ../fastRPCA/inst/libs/libfastpca.dylib @rpath/libfastpca.dylib ../src/fastRPCA.so",system.file("libs", package="fastRPCA") ))
}
files <- Sys.glob(paste0("*", SHLIB_EXT))
dest <- file.path(R_PACKAGE_DIR, paste0('libs', R_ARCH))
dir.create(dest, recursive = TRUE, showWarnings = FALSE)
file.copy(files, dest, overwrite = TRUE)
if(file.exists("symbols.rds"))
    file.copy("symbols.rds", dest, overwrite = TRUE)

