#!/bin/sh

git push origin master
zip lambda_function.zip lambda_function.rb vendor
aws lambda update-function-code --function-name catch-webhook-event --zip-file fileb://lambda_function.zip
STG_ENVIRONMENTS=$(ruby export_stg_envs.rb) 
aws lambda update-function-configuration --function-name catch-webhook-event --environment Variables=${STG_ENVIRONMENTS}
rm lambda_function.zip