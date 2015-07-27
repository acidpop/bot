#! /bin/sh

#usage) systeminfo.sh /home/pi/tg/bot/tmp/sysinfo.txt
# 인자 값으로 출력 내용이 저장될 파일 경로를 지정

# measure_clock   arm     ARM 프로세서의 클록 속도
# measure_clock   core    코어 주파수(Hz)
# measure_temp    없음    코어 온도
# measure_volts   없음    시스템 전압
# get_mem         arm     또는 gpu CPU와 GPU의 메모리 분할 정보
# version         없음    펌웨어 버전
# set_backlight   없음    LCD 디스플레이 장치의 백라이트 제어(추후 지원)


if [ 0 -eq $# ]
then
    exit 0
fi

RESULTPATH=$1
# CPU Usage
echo "CPU Usage  : "`top -n 1 | grep -i cpu\(s\)| awk '{print $8}' | awk '{print 100-$1}'` > $RESULTPATH

#CPU Info
# CPU 온도
CPUTEMP=`vcgencmd measure_temp | cut -d"=" -f2`

echo "CPU temp   : $CPUTEMP" >> $RESULTPATH

# Memory Info
MEMORY_FREE=`free -m | awk 'NR==2{printf "%sMB/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'`
echo "Memory Use : "$MEMORY_FREE >> $RESULTPATH

# Disk Info
DISK_INFO=`df -h | grep rootfs | awk '$NF=="/"{printf "%dGB/%dGB (%s)\n", $3,$2,$5}'`
echo "Disk Info  : "$DISK_INFO >> $RESULTPATH

