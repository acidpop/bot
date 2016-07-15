# tgbot
Acidpop Telegram BOT Script


	git clone https://github.com/acidpop/bot.git

# 2016/07/15
 - GPIO 0번과 1번에 Relay Switch를 연결하고, 이를 이용하여 원격으로 서버(컴퓨터)를 끄고 켤수 있음
 (명령어 : 서버 <켜><꺼><상태> 등등..상세 사용방법은 help.txt 참고)
 - 라즈베리파이의 시스템 상태 체크 기능 복구 (디스크 용량이 정상적으로 뜨지 않던 문제 개선)
 - 라즈베리파이의 시스템 상태 체크 명령어에서 IP, 로그온 상태 부분 추가
 
# 2016/06/07
 - Bot Lua 스크립트에서 Telegram CLI 가 업데이트 되면서 msg.to.id 가 msg.to.peer_id 로 변경 된 부분 수정.

# 2016/01/11
 - url_download 함수 누락된 부분 추가

# 2016/01/08
 - torrent.lua 에서 split_to_table 함수 이름 변경

# 2015/12/16
 - tdget.sh 파일에서 torrent 사이즈 주소 수정

# 2015/11/04
 - torrent.lua 에서 Torrent 파일명 추출 코드 수정

# 2015/10/07
 - 날씨 조회 API 스크립트에서 동네 이름을 입력하지 않으면 스크립트 오류가 나는 문제 수정

# 2015/09/24
 - Shell Mode 에서 shell_path 정보를 삭제 하는 버그 수정

# 2015/09/22
 - Shell Mode 추가

# 2015/09/10
 - 라즈베리파이 시스템 상태 체크 기능 중 메모리 사용량 계산 부분 수정


# 2015/08/31
 - Torrent Down 사이트 차단으로 인해 URL이 변경 되었습니다


# 2015/07/31
 - 저항 계산기 추가





Reference : https://github.com/vysheng/tg
