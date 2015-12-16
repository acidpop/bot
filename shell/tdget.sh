#! /bin/sh

# usage) tdget.sh "Torrent 검색어"
# Torrent 검색어는 꼭 큰 따옴표로 묶어서 실행

if [ 0 -eq $# ]
then
    exit 0
fi

SEARCH_KEY=$1

# Torrent Project Search
curl -s -G -L "http://torrentproject.se/" --data-urlencode "s=$SEARCH_KEY" --data-urlencode "out=rss" | xml2 | grep -E 'item/title=|item/enclosure/@url' | cut -f 2 -d '='
# Torrent Down Search
# magnet 링크 지원
curl -s -k -G -L "https://torrentkim.com/bbs/rss.php" --data-urlencode "k=$SEARCH_KEY" | sed 's/&/&amp;/g' | xml2 | grep -E 'item/title|item/link' | sed 's/\/rss\/channel\/item\/title=//g' | sed 's/\/rss\/channel\/item\/link=//g'

