#!/bin/sh

# usage) getwether.sh 123456
# 동네 코드를 이용하여 rss 를 가져와 첫번째 날씨 데이터 정보를 출력하는 기능

if [ 0 -eq $# ]
then
    exit 0
fi

CODE=$1

IDX=0
RESULT=`curl -s "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=$CODE" | xmlstarlet sel -t -c "/rss/channel/item/description/body/data[@seq="0"]" | xml2 | grep -E 'temp|wfKor|pop|ws|wdKor|reh' | cut -d '=' -f 2`

echo "$RESULT" | while read line
do
    case $IDX in
        0)  echo "온도 : ${line}C"  ;;
        1)  echo "날씨 : ${line}"   ;;
        2)  echo "강수 확률 : ${line}%" ;;
        3)  SPEED=`echo ${line} | awk '{printf "%.1f", $1}'`
            echo "풍속 : ${SPEED}m/s"
        ;;
        4)  echo "풍향 : ${line}"   ;;
        5)  echo "습도 : ${line}%"  ;;
    esac
    IDX=`expr $IDX + 1`
done

