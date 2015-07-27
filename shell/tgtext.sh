#! /bin/sh

# usage) tgtext.sh 홍길동 "전달할 메시지
# 전달할 메시지는 꼭 큰 따옴표로 묶어서 실행

argc=$#

DSM_LOG=/var/log/tgsend.log

if [ 0 -eq $# ]
then
    exit 0
fi


echo "[1] $1" >> $DSM_LOG
echo "[2] $2" >> $DSM_LOG

echo "send_text $1 $2" | nc localhost 4500 -q 1

