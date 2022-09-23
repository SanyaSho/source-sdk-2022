#!/bin/sh

if ! [ -d source-sdk-2013 ];then
git clone --depth 1 https://github.com/ValveSoftware/source-sdk-2013
fi

LIST=$(git diff --name-only)

BRANCH=sp

# 1st step
for i in $LIST;do
	diff $i source-sdk-2013/$BRANCH/src/$i &> /dev/null && git checkout $i
done

LIST=$(git diff --name-only)
echo "LIST TO CHECK:"
for i in $LIST;do
	D=$(git diff master:$i 2013base:$i)
	if ! [ -z "$D" ];then
		echo "=========================================="
		echo $i
		echo "=========================================="
		diff $i source-sdk-2013/$BRANCH/src/$i
	fi
done
