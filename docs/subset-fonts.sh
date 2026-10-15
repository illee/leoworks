#!/bin/sh
# Pretendard 서브셋 재생성 — 홈·허브 문안에 새 한글 글자가 들어가면 다시 돌린다.
# 필요: pip install fonttools brotli  · 원본 = bizdsg design/assets/fonts (OFL)
set -e
cd "$(dirname "$0")/.."
python3 -c "
import html
s=''.join(html.unescape(open(f).read()) for f in ['index.html','tools/index.html'])
open('/tmp/lw-chars.txt','w').write(''.join(sorted(set(c for c in s if ord(c)>127))))"
for w in 500:Medium 600:SemiBold 700:Bold 800:ExtraBold; do
  pyftsubset ~/apps/bizdsg/design/assets/fonts/Pretendard-${w##*:}.ttf \
    --unicodes="U+0020-007E,U+00A0-00FF,U+2010-2027,U+2030-203A,U+2190-2199,U+2122,U+20A9" \
    --text-file=/tmp/lw-chars.txt --flavor=woff2 --layout-features='kern,liga,tnum' \
    --output-file=assets/fonts/pretendard-${w%%:*}.woff2
done
