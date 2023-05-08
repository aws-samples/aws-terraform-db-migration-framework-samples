#!/bin/bash
sleeptime=$2
SecondsPerMinute=60
PipelineName=$1
looptime=$((sleeptime / SecondsPerMinute))

aws codepipeline start-pipeline-execution --name $PipelineName

sleep 10

x=1
while [ $x -le $looptime ]
pipeline_Status=$(aws codepipeline list-pipeline-executions --pipeline-name $PipelineName --query 'pipelineExecutionSummaries[0].status')
if [ $? -eq 0 ]; then
   echo "OK"
else
   echo "FAIL"
   exit 1;
fi
pipeline_current_status=$(echo $pipeline_Status | tr -d '"')
do
    if [ ${pipeline_current_status} == "Succeeded" ]
    then
        echo "This stage is successful"
        exit 0
        #x=$(( $x + 1 ))
    elif [ ${pipeline_current_status} == "InProgress" ]
    then
        echo "This stage still Inprogress"
        sleep 60
        continue
        x=$(( $x + 1 ))
    elif [ ${pipeline_current_status} == "Failed" ]
    then
        echo "Child pipeline failed with some reason. Please check"
        exit 1;
    else
        echo "This is not the expected state. Kindly check the Child pipeline"
        exit 1;
    fi
done
