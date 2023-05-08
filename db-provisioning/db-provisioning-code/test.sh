#!/bin/sh
pre-commit run -a
if [ $? -ne 0 ]; then
 echo "unit tests failed"
 exit 1
fi
