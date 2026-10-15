# 리뷰 입력 보완 r2 (2026-10-15, bizdsg 요청)

- 모든 캡처는 전 페이지를 300px씩 스크롤한 뒤(lazy 적재) `img.complete && naturalWidth>0`가 전부 참일 때까지 기다리고, `document.fonts.ready` 뒤 찍었다. 수치 = `checks.json`.
- 1차 캡처(`../tools-en-390.png` 등)는 `loading="lazy"` 이미지가 적재되기 전이라 아이콘이 비어 있다 — r2로 대체.
- 320px: `home-en-320` · `home-ko-320` · `tools-en-320` — scrollWidth = 320(가로 스크롤 0).
- 200% 확대: `zoom200-*` = Chrome에서 창 1280px을 200%로 확대했을 때와 같은 조건(CSS 뷰포트 640px + devicePixelRatio 2, checks.json의 innerWidth·dpr). Playwright는 브라우저 메뉴 확대(Cmd +)를 직접 조작할 수 없어 이 조건으로 재현했다. scrollWidth = 640.
- 글꼴 크기 설정 200%: `fontsize32-home-en-1280` = Chrome 기본 글꼴 크기 32px(기본 16px의 200%) 설정(CDP `Page.setFontSizes`). **결과: html은 32px이 되지만 body 16px·h1 56px 그대로 — site.css가 px 단위라 글꼴 크기 설정만으로는 글자가 커지지 않는다.** 브라우저 확대(위)로는 커진다.
