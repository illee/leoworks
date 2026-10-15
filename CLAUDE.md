# leoworks — leoworks.kr 회사 사이트

> 이 파일은 Claude Code가 세션 시작 시 자동으로 읽는다. 2026-10-15 신설(발주 = `~/apps/bizdev/candidate/2026-10-15-leoworks-site-refresh-brief.md` §1).

## 소유

| 범위 | 소유 세션 | 비고 |
|---|---|---|
| 레포 전체(홈 `index.html`·`/tools/` 허브·가이드·`assets/`·`sitemap.xml`·배포) | **bizmkt** (`~/apps/bizmkt`) | 문안(영문 원본·한국어 번역)·마크업·SEO·배포 |
| 앱 방침·삭제 요청 페이지(`*/privacy/`·`*/delete*/`)·앱 기능 페이지(`join/`·`osolog/roadview/`) | 각 앱 세션 | Play 데이터 안전 선언이 참조 — bizmkt는 손대지 않는다 |
| `.well-known/assetlinks.json`·`app-ads.txt` | 각 앱 세션(앱 링크·AdMob) | 내용 변경 금지, 위치 유지 |
| 디자인 규격(토큰·로고·OG) | bizdsg | 가이드 = 발주서 §7-1, 정본 `~/apps/bizdsg/docs/guides/2026-10-15-leoworks-site-refresh.md` |
| 회사 인프라 문서(사업자·결제·Play 조직계정) | vault `bizapps/leoworks/` | 이 레포에 다시 적지 않는다 |

## 배포

- GitHub Pages(Jekyll) · 원격 `illee/leoworks` · `main` = 공개 사이트(`CNAME` = leoworks.kr). `docs/`는 `_config.yml`에서 제외(내부 문서 보존용).
- 공개 페이지 변경은 **브랜치에서 작업 → 로컬 미리보기 → 사용자 승인 → `main` 머지·푸시**(전역 규칙: 머지 전 보안 스캔).
- 로컬 미리보기: `python3 -m http.server 4000` (Liquid를 쓰지 않으므로 Jekyll 없이 같은 결과).

## 사이트 규칙

- **기본 언어 = 영문**(2026-10-15 사용자 결정). 홈은 `data-en`/`data-ko` 문안 + KO 토글(`?lang=ko`·localStorage). 정적 HTML의 텍스트는 영문으로 두어 색인되게 한다. hreflang·언어별 URL은 쓰지 않는다.
- **홈 순서 고정**: Hero → Data tools(집중 3종) → Shopify apps → Mobile apps → About → Contact·푸터.
- **외부 링크 집중**: 홈은 집중 3종(#1 Google Maps Review Classifier · #11 Korean Review Classifier · #21 AliExpress Reviews Scraper)만 Apify 직접 링크(`utm_content=home`), 나머지는 `/tools/`로. 허브 링크는 `utm_content=tools-hub`.
- 액터 번호·상태 SSOT = `~/apps/apify-actors-2610/docs/actor-numbering.md`. 가격·문구는 각 액터 README/actor.json과 대조한 실값만 쓴다.
- **쓰지 않는 것**: Etsy 언급, 가격 변경 예고, 지어낸 수치, 업체명(가이드 사례는 익명).
- 스타일: 공통 = `assets/site.css`(+ `assets/tokens.css` = bizdsg 생성물 사본, 손대지 않음). 사자 로고·favicon·OG = `assets/brand/`.
- 서체 = Pretendard 서브셋(`assets/fonts/`, OFL). **홈·허브 문안에 새 한글 글자를 넣으면 `docs/subset-fonts.sh`로 다시 만든다**(없는 글자는 시스템 폰트로 대체돼 섞여 보인다).
- 사업자 정보(레오웍스 · 640-53-01064 · support@leoworks.kr)는 바꾸지 않는다.
