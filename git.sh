#!/bin/bash
#[shell][1、shell 提交代码测试]
comment=${1:-[feature][1、提交代码]}
git add .
git commit -m"$comment"
git pull
git push