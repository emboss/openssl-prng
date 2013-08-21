#!/bin/bash

pushd ../1.0.1e
make clean
make
popd

make clean
make
LD_LIBRARY_PATH=../1.0.1e:$LD_LIBRARY_PATH ./recycle_pid

