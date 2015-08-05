#!/bin/sh

# 동네 코드를 기준으로 날씨를 조회하는 스크립트
# crontab 에 등록하여 일정 시간에 실행 되도록 사용하기 위해 작성된 스크립트
# usage) sendwether.sh 홍길동 123456 /home/pi/tg/bot/tmp/wether.txt


if [ 0 -eq $# ]
then
    exit 0
fi

USER=$1
CODE=$2
WETHER_PATH="/tmp/$USER.txt"

# 날씨 정보에 시/구/동 정보를 표시 하기 위한 Query 문
DONGNE=`sqlite3 /home/pi/tg/bot/tgbot.db "SELECT SIDO || ' ' || GUGUN || ' ' || DONG FROM kma_dongne WHERE code = $CODE;"`

`echo $DONGNE > $WETHER_PATH`
`/home/pi/tg/bot/shell/getwether.sh $CODE >> $WETHER_PATH`
`/home/pi/tg/bot/shell/tgtext.sh $USER "$WETHER_PATH"`

