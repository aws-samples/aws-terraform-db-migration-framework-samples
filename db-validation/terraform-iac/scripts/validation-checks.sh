#!/bin/bash
 
region=$2
#Regex
Regex_Acct='^[0-9]{12}$'
Regex_Vpc='^vpc-'
Regex_Sg='^sg-'
Regex_Subnet='^subnet-'

check_account() {
    # Validate Account number by verifying assumed IAM role
    echo $2
    accountid=`aws ssm get-parameter --name "/demo/dbdevops/target/infra/aws_account_id"   --output text --query Parameter.Value --output text --query Parameter.Value --region $region`
    [[ $accountid =~ $Regex_Acct ]]
    if [ $? -eq 0 ]; then
        currrent_accountid=`aws sts get-caller-identity --query "Account" --region $region | xargs` 
        if [ $accountid == $currrent_accountid ]; then
            echo "Account Number $accountid is valid and exist."
        else
            echo "Invalid Account Number $accountid."
            return 1
        fi
    else
        echo "Invalid Value for Account id, Please provide valid 12 digit AWS Account Number. Input Provided: $accountid"
        return 1
    fi
}

check_infra() {
    # Validate vpc exist or not
    vpcid=`aws ssm get-parameter --name "/demo/dbdevops/target/infra/vpc_id" --region $region --output text --query Parameter.Value`
    subnet_ids=`aws ssm get-parameter --name "/demo/dbdevops/target/infra/subnet_ids" --region $region --output text --query Parameter.Value`
    [[ $vpcid =~ $Regex_Vpc ]]
    if [ $? -eq 0 ]; then
        aws ec2 describe-vpcs --vpc-ids "$vpcid" --region $region 
        if [ $? -eq 0 ]; then
            echo "VPC id $vpcid exist."
        else
            echo "VPC id $vpcid does NOT exist."
            return 1
        fi
    else
        echo "Invalid Value for VPC id, Please provide valid VPC id. Input Provided: $vpcid"
        return 1
    fi

    # Validate given private subnet exist or not
    array=($(echo $subnet_ids | sed -e 's/\[//g' -e 's/\]//g' -e 's/\,/ /g'))
    echo "${array[@]}"  
    for subnetid in "${array[@]}" ; do
        subnetid=`sed -e 's/^"//' -e 's/"$//' <<<"$subnetid"` 
        [[ $subnetid =~ $Regex_Subnet ]]
        if [ $? -eq 0 ]; then
            privatesubnet=`aws ec2 describe-subnets --filter "Name=vpc-id,Values=$vpcid" --subnet-ids $subnetid --query 'Subnets[?MapPublicIpOnLaunch==\`false\`].SubnetId' --region $region` 
            if [ $? -eq 0 ]; then
                echo "Subnet id $subnetid exist."
                    if [ "$privatesubnet" == "[]" ]; then
                        echo "Subnet id $subnetid is NOT Private."
                        return 1
                    else
                        echo "Subnet id $subnetid is a Private subnet."
                    fi
            else
                echo "Subnet id $subnetid does NOT exist."
                return 1
            fi
        else
            echo "Invalid Value for Subnet, Please provide valid Subnet id. Input Provided: $subnetid"
            return 1
        fi
    done
}


check_security_groups() {
    # Validate security group exist or not
    securitygroup=`aws ssm get-parameter --name "/demo/dbdevops/target/infra/sg_id" --region $region --output text --query Parameter.Value`
    [[ $securitygroup =~ $Regex_Sg ]]
    if [ $? -eq 0 ]; then
        aws ec2 describe-security-groups --group-ids "$securitygroup"  --region $region  
        if [ $? -eq 0 ]; then
            echo "Security Group id $securitygroup exist."
        else
            echo "Security Group id $securitygroup does NOT exist."
            return 1
        fi
    else
        echo "Invalid Value for Security Group id , Please provide valid Security Group id. Input Provided: $securitygroup"
        return 1
    fi
}

check_source_db_reachable() {
    echo "Validating Connection..."
    echo "Source DB reachable succesfully"
    parameterusername=`aws secretsmanager get-secret-value --secret-id $source_secret_mgr  --query SecretString  --output text --region $region| jq -r .username`
    parameterpassword=`aws secretsmanager get-secret-value --secret-id $source_secret_mgr  --query SecretString  --output text --region $region| jq -r .password`
    parameterip=`aws ssm get-parameter --name "/demo/dbdevops/source/db/host" --region $region --output text --query Parameter.Value`
    parameterport=`aws ssm get-parameter --name "/demo/dbdevops/source/db/port" --region $region --output text --query Parameter.Value`
    # connectionop=`nc -w 2 -nzv $sourceip $sourceport 2>&1`   
    # echo "Connection Output of nc: $connectionop"

    # if [[  $connectionop == *"Connected"* ]]; then
    # echo "Connected to Server:$sourceip  and Port:$sourceport "
    # elif [[ $connectionop == *"timed out"* ]]; then
    #     echo "Connection timed out for Server:$sourceip  and Port:$sourceport"
    #     return 1
    # else 
    #     echo "Connection Refused for Server:$sourceip  and Port:$sourceport"
    #     return 1
    # fi
}

check_ssm_params() {
    # Validate ssm parameter exist or not
    echo "Validating SSM Parameter Store parameters..."
    parameterusername=`aws secretsmanager get-secret-value --secret-id $source_secret_mgr  --query SecretString  --output text --region $region| jq -r .username`
    parameterpassword=`aws secretsmanager get-secret-value --secret-id $source_secret_mgr  --query SecretString  --output text --region $region| jq -r .password`
    parameterip=`aws ssm get-parameter --name "/demo/dbdevops/source/db/host" --region $region --output text --query Parameter.Value`
    parameterport=`aws ssm get-parameter --name "/demo/dbdevops/source/db/port" --region $region --output text --query Parameter.Value`
}

if [[ -z $1 ]];
then 
    echo "No parameter provided for validation check."
    echo "Valid Input parameters: account, infra, source, ssm"
    echo "Please re-run script with valid input parameter."
    exit 1
else
    echo "Parameter provided for validation: $1"
    
    echo "Executing Validations in AWS Region: $2 "
    echo $2
    if [ $1 == "account" ]
    then
        check_account
    elif [ $1 == "infra" ]
    then
        check_infra
    elif [ $1 == "sg" ]
    then
        check_security_groups
    elif [ $1 == "source" ]
    then
        check_source_db_reachable
    elif [ $1 == "ssm" ]
    then
        check_ssm_params
    else 
        echo "Invalid paramter passed to script"
        echo "Valid Input parameters: account, infra, source, ssm"
        echo "Please re-run script with valid input parameter."
        exit 1
    fi

    if [ $? == 1 ] 
    then
        echo "Validation has been Failed."
        exit 1
    else
        echo "Success..."
        echo "Validation has been succesfully completed."
    fi
fi