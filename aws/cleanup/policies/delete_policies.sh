#!/bin/bash

preamble=$1

policies=$(aws iam list-policies|grep ${preamble}|grep "arn"|awk -F '"' '{print $4}')

for i in $policies; do
	echo "Deleting policy: $i"
	aws iam delete-policy --policy-arn "$i"
done
