#!/bin/sh -x

#get script location
SCRIPTDIR=`dirname $0`
SCRIPTDIR=`(cd $SCRIPTDIR ; pwd)`
#get working directory
TOP=`pwd`

#temporary directory
WDIR=`mktemp -d` && trap "rm -Rf $WDIR" EXIT
#WDIR=`mktemp -d`

#untar toolset and runtime
cd ${WDIR}
tar xf ${TOP}/out/toolset-*
tar xf ${TOP}/out/runtime-*

#run testsuite
env PATH=${WDIR}/bin:${PATH} ./runme.sh
