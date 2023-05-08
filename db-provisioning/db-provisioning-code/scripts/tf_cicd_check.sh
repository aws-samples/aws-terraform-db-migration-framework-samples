#!/bin/bash
# Accept Command Line Arguments
SKIPVALIDATIONFAILURE=$1
tfValidate=$2
tfFormat=$3
tfCheckov=$4
tflint=$5
tfdocs=$6
tfscan=$7
tfsec=$8
# -----------------------------

echo "### VALIDATION Overview ###"
echo "-------------------------"
echo "Skip Validation Errors on Failure : ${SKIPVALIDATIONFAILURE}"
echo "Terraform Validate : ${tfValidate}"
echo "Terraform Format   : ${tfFormat}"
echo "Terraform checkov  : ${tfCheckov}"
echo "Terraform tflint   : ${tflint}"
echo "Terraform docs     : ${tfdocs}"
echo "Terraform scan     : ${tfscan}"
echo "Terraform sec      : ${tfsec}"
echo "------------------------"

echo "Initializing terraform code"
#Terraform Initialization
terraform init


#Validate
if (( ${tfValidate} == "Y"))
then
    echo "## VALIDATION : Validating Terraform code ..."
    terraform validate
fi
tfValidateOutput=$?

#Format
if (( ${tfFormat} == "Y"))
then
    echo "## VALIDATION : Formatting Terraform code ..."
    terraform fmt -recursive
fi
tfFormatOutput=$?

#Checkov
if (( ${tfCheckov} == "Y"))
then
    echo "## VALIDATION : Running checkov ..."
    #checkov -s -d .
    checkov -d . -o junitxml  > checkov.xml
fi
tfCheckovOutput=$?


#TFlint
if (( ${tflint} == "Y"))
then
    echo "## VALIDATION : Running tflint ..."
    tflint -f junit > tflint_report.xml
fi
tflintOutput=$?

#Tfdocs
if (( ${tfdocs} == "Y"))
then
    echo "## VALIDATION : Running tfdocs ..."
    #tfsec .
    terraform-docs markdown . > output.txt
fi
tfdocsOutput=$?

#Tfscan
if (( ${tfscan} == "Y"))
then
    echo "## VALIDATION : Running tfscan ..."
    #tfsec .
    terrascan > tfscan.txt
fi
tfscanOutput=$?

#Tfsec
if (( ${tfsec} == "Y"))
then
    echo "## VALIDATION : Running tfscan ..."
    #tfsec .
    tfsec . > tfsec.txt
fi
tfsecOutput=$?

echo "## VALIDATION Summary ##"
echo "------------------------"
echo "Terraform Validate : ${tfValidateOutput}"
echo "Terraform Format   : ${tfFormatOutput}"
echo "Terraform checkov  : ${tfCheckovOutput}"
echo "Terraform tflint   : ${tflintOutput}"
echo "Terraform tfdocs   : ${tfdocsOutput}"
echo "Terraform tfscan   : ${tfscanOutput}"
echo "Terraform tfsec    : ${tfsecOutput}"
echo "------------------------"

if (( ${SKIPVALIDATIONFAILURE} == "Y" ))
then
  #if SKIPVALIDATIONFAILURE is set as Y, then validation failures are skipped during execution
  echo "## VALIDATION : Skipping validation failure checks..."
elif (( $tfValidateOutput == 0 && $tfFormatOutput == 0 && $tfCheckovOutput == 0  && $tflintOutput == 0 && $tfdocsOutput == 0 && $tfscanOutput == 0 && $tfsecOutput == 0))
then
  echo "## VALIDATION : Checks Passed!!!"
else
  # When validation checks fails, build process is halted.
  echo "## ERROR : Validation Failed"
  exit 1;
fi
