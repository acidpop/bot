#! /bin/bash

if [ 0 -eq $# ]
then
    exit 0
fi

gpio mode 0 out
gpio mode 1 in

ARGUMENT=$1
##키워드##
off_command=("꺼줘" "종료" "정지" "꺼줭" "끄기" "꺼" "꺼주세요" "꺼줘라" "off" "shutdown")
on_command=("켜줘" "시작" "켜기" "켜줭" "켜" "켜라" "켜줘라" "on")
force_command=("강제종료")
status_command=("상태" "지금" "어떤데" "켜졌냐?" "꺼졌냐?" "켜졌냐" "꺼졌냐")
STATUS=`gpio read 1`
###서버 끄기 ###
for value in "${off_command[@]}"; do
if [ "$ARGUMENT" = "$value" ]; then
        ##켜진 상태 : 정상 종료##
        if [ "$STATUS" == "1" ]; then
                gpio write 0 1
                sleep 0.5
                gpio write 0 0
                echo "msg OWNER 서버를 종료합니다" | nc -q 1 localhost 8888
        else    ##꺼진 상태##
                echo "msg OWNER 서버가 이미 꺼져있습니다" | nc -q 1 localhost 8888
        fi
fi
done
### 서버 켜기 ###
for value in "${on_command[@]}"; do
if [ "$ARGUMENT" = "$value" ]; then
        ##켜진 상태 : 정상 종료##
        if [ "$STATUS" == "1" ]; then
                echo "msg OWNER 서버는 이미 켜져있습니다" | nc -q 1 localhost 8888
        else    ##꺼진 상태##
                gpio write 0 1
                sleep 0.5
                gpio write 0 0
                echo "msg OWNER 서버를 시작합니다" | nc -q 1 localhost 8888
        fi
fi
done
### 강제 동작 ###
for value in "${force_command[@]}"; do
if [ "$ARGUMENT" = "$value" ]; then
        ##켜진 상태 : 정상 종료##
		if [ "$STATUS" == "1" ]; then
                gpio write 0 1
                sleep 4
                gpio write 0 0
                echo "msg OWNER 서버를 강제종료 합니다." | nc -q 1 localhost 8888
        else    ##꺼진 상태##
                echo "msg OWNER 서버는 이미 꺼져있습니다" | nc -q 1 localhost 8888
        fi
fi
done
###서버 상태 체크###
for value in "${status_command[@]}"; do
if [ "$ARGUMENT" = "$value" ]; then
        if [ "$STATUS" == "1" ]; then
                echo "msg OWNER 켜져있습니다. == ON" | nc -q 1 localhost 8888
        else    ##꺼진 상태##
                echo "msg OWNER 꺼져있습니다. == OFF" | nc -q 1 localhost 8888
        fi
fi
done