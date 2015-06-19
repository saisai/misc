#!/bin/bash

# exit immediately if a command fails
set -e

DICT=/usr/share/dict/words
RAWFILE=/tmp/raw.$$;
ECCFILE=/tmp/ecc.$$;
DECFILE=/tmp/dec.$$;
ECC=../ecc

if [ ! -x ${ECC} ]; then echo "run \"make\" first, then try again"; exit -1; fi

dd if=/dev/urandom of=${RAWFILE} bs=1 count=1000

echo encoding...
${ECC} -i ${RAWFILE} -o ${ECCFILE}
echo decoding...
${ECC} -d -i ${ECCFILE} -o ${DECFILE}
echo resulting files:
ls -lt ${RAWFILE} ${ECCFILE} ${DECFILE}
echo diffing...
diff -q ${RAWFILE} ${DECFILE}
if [ $? -eq 0 ]; then rm ${RAWFILE} ${ECCFILE} ${DECFILE}; fi
echo done
