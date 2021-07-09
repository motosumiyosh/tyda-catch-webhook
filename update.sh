#!/bin/sh

git push origin master
zip lambda_function.zip lambda_function.rb vendor
aws lambda update-function-code --function-name catch-webhook-event --zip-file fileb://lambda_function.zip
rm lambda_function.zip