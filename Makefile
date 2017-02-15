# CULDFLAGS=-L/usr/local/cuda/lib
# CUDADIR      ?= /usr/local/cuda
# OPENBLASDIR  ?= /opt/openbas
#
# MAGMADIR ?= /usr/local/magma
# MAGMA_LIBS       := -L$(MAGMADIR)/lib -lmagma_sparse -lmagma \
#                     -L$(CUDADIR)/lib64 -lcublas -lcudart -lcusparse -lcurand \
# 					-L$(OPENBLASDIR)/lib -lopenblas
# 					# -fopenmp
#
# MAGMA_CFLAGS     := -DADD_ \
#                     -I$(MAGMADIR)/include \
#                     -I$(MAGMADIR)/sparse/include \
#                     -I$(CUDADIR)/include
#
# # MAGMA_F90FLAGS   := -Dmagma_devptr_t="integer(kind=8)" \
# #                     -I$(MAGMADIR)/include
#
# test: cgls_test.cu cgls.cuh
# 	nvcc -O3 -m64 -arch=sm_20 $(MAGMA_CFLAGS) -o $@  $(MAGMA_LIBS) -Xcompiler -fopenmp $<
# 	./test
#
# clean:
# 	rm -rf *.o test
LDFLAGS       = -Wall #-fopenmp
CFLAGS 		= -Wall
CC = nvcc
LD = nvcc

MAGMADIR     = /usr/local/magma
CUDADIR      ?= /usr/local/cuda
OPENBLASDIR  ?= /opt/openblas

MAGMA_CFLAGS     := -DADD_ \
                    -I$(MAGMADIR)/include \
                    -I$(MAGMADIR)/sparse/include \
                    -I$(CUDADIR)/include

MAGMA_LIBS       := -L$(MAGMADIR)/lib -lmagma_sparse -lmagma \
                    -L$(CUDADIR)/lib64 -lcublas -lcudart -lcusparse -lcurand\
                    -L$(OPENBLASDIR)/lib -lopenblas

all: c
c: cgls_test

.SUFFIXES:
%.o: %.cu
	$(CC) $(MAGMA_CFLAGS) -c -o $@ $<
cgls_test: cgls_test.o
	$(LD) -o $@ $^ $(MAGMA_LIBS)
	# ./cgls_test
clear:
	rm -rf *.o test
