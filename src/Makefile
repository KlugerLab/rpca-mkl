MKL_INCLUDE=/opt/intel/compilers_and_libraries_2019.4.233/mac/mkl/include/ #Replace with the path on your machine

EXE_INCLUDEPATH=-I../include
#CFLAGS=-O3 -std=c++0x -m64 -DMKL_ILP64 -fopenmp -DDEBUG -DUSE_MKL
CFLAGS=-O3 -std=c++0x -m64 -DMKL_ILP64   -Xpreprocessor  -DUSE_MKL

platform=$(shell uname)
ifeq ($(platform),Darwin)
#mac
CFLAGS += -DOSX
EXE_INCLUDEPATH = -I../include  -I$(MKL_INCLUDE)
CFLAGS+=-DMKL_CUSTOM_LIBRARY='"libfastpca_custommkl.dylib"'
LIBS =  -L../lib  -lfastpca_custommkl -L../lib -liomp5 -ldl -lpthread -lm   -DMKL_ILP64 -m64
CC = /usr/bin/clang++
R_TARGET = ../fastRPCA/inst/libs/libfastpca.dylib

else

#Linux
CFLAGS+=-DMKL_CUSTOM_LIBRARY='"libfastpca_custommkl.so"'
EXE_INCLUDEPATH = -I../include -I$(MKL_INCLUDE)
LIBS =  -Wl,--no-as-needed  -L../lib -lfastpca_custommkl -liomp5 -ldl -lpthread -lm
CC = g++
R_TARGET = ../fastRPCA/inst/libs/libfastpca.so

endif


EXE_CPP_FILES := $(wildcard *.cpp)
EXE_OBJ_FILES := $(addprefix ../build/,$(notdir $(EXE_CPP_FILES:.cpp=.o)))
EXE_TARGET = ../build/fastpca.xx


all: EXE_target R_target

debug: CFLAGS += -DDEBUG
debug: EXE_target R_target

#Cleans all the objects
clean:
	rm -f $(EXE_OBJ_FILES) $(R_OBJ_FILES) $(EXE_TARGET) $(R_TARGET)

#Link the objects into the final EXE executable
EXE_target: $(EXE_OBJ_FILES) 
	$(CC) $(CFLAGS) -o $(EXE_TARGET) $(EXE_OBJ_FILES) $(LIBS)

#Link the objects into the final R library
R_target: $(EXE_OBJ_FILES) 
	$(CC) $(CFLAGS) -o $(R_TARGET) $(EXE_OBJ_FILES) $(LIBS) -shared
	cp ../include/ExternalInterface.h ../fastRPCA/src

#Build the CPP files into objects
../build/%.o: %.cpp
	$(CC) $(CFLAGS) -fPIC -c -o $@ $< $(EXE_INCLUDEPATH) 
