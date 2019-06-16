##On OS X
#First make a dynamic library that exports the necessary functions
sudo make -C /opt/intel/mkl/tools/builder/ libuni export=`pwd`/mkl_fxn_list name=`pwd`/libfastpca_custommkl

#Adjust the install_name so that the executable will find the relative to the @rpath (that we set during compilation of the executable)
sudo install_name_tool -id "@rpath/libfastpca_custommkl.dylib" libfastpca_custommkl.dylib
sudo install_name_tool -id "@rpath/libiomp5.dylib" libiomp5.dylib
sudo install_name_tool -change libiomp5.dylib @rpath/libiomp5.dylib libfastpca_custommkl.dylib

cp libfastpca_custommkl.dylib ../fastRPCA/inst/libs/


##On Linux
#First make a dynamic library that exports the necessary functions
make -C /opt/intel/mkl/tools/builder/ libintel64 export=`pwd`/mkl_fxn_list name=`pwd`/libfastpca_custommkl
cp libfastpca_custommkl.so ../fastRPCA/inst/libs/
