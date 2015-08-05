#! /bin/sh
# Raspberry pi Camera still image Shell script

# usage stillcamera.sh /home/pi/tg/bot/tmp/tele.jpg"


if [ 0 -eq $# ]
then
    exit 0
fi


IMAGE_PATH=$1

# raspistill 은 인터넷 검색을 이용하여 옵션을 조정한다.
# 아래는 quality 를 30으로 설정해서 촬영하는 옵션이다
raspistill -q 30 -o $IMAGE_PATH

# convert 는 imagemagick 를 설치 하여 사용 할 수 있다. (sudo apt-get install imagemagick)
# 촬영된 이미지를 180도 회전 하는 명령이다
convert -rotate 180 $IMAGE_PATH $IMAGE_PATH
