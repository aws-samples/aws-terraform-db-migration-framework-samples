#!/bin/sh

# Run pre commit hook 
pre-commit run -a

if [ $? -ne 0 ]; then
 echo "Some checks failed"
 exit 1
fi

# Run ASH as Pre-commit hook 

# if [ "`dirname $0`" == "." ]; then 
#    SRC_DIR=`pwd`
# else
#    SRC_DIR=`dirname $0`
# fi
# 
# OUT_DIR=`echo ${SRC_DIR}/ash_check_output`
# 
# if [ ! -d ${OUT_DIR} ]; then 
#    mkdir -p ${OUT_DIR}
# fi 
# 
# ash --source-dir ${SRC_DIR} --output-dir ${OUT_DIR}
# 
# if [ $? -ne 0 ]; then
#  echo "ASH Check Failed"
#  exit 1
# else
#  echo "ASH Check Passed"  
# fi

# Automated Drawio to PNG Conversion 

# /Applications/draw.io.app/Contents/MacOS/draw.io -x -f png -t -o architecture.png architecture.drawio
