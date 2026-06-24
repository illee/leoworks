# LeoWorks 랜딩 페이지 + leoworks.kr 연결 — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 기존 `illee/leoworks` GitHub Pages 리포의 최소 랜딩을 한/영 토글 포트폴리오 랜딩으로 확장하고, `leoworks.kr` 커스텀 도메인을 연결한다.

**Architecture:** 단일 `index.html`(빌드 단계 없음). 손수 작성한 CSS + 의존성 없는 vanilla JS로 한/영 토글. 도메인은 리포 `CNAME` 파일 + 등록처 DNS + GitHub Pages 설정으로 연결. 정적 1파일이라 별도 JS 유닛테스트 하네스는 도입하지 않는다(YAGNI) — 검증은 ① `rg` 구조 점검 ② Playwright 동작 점검 ③ 브라우저 육안 + 배포 후 `dig`/`curl`로 한다.

**Tech Stack:** HTML5 / CSS3 / vanilla JS / GitHub Pages / Playwright(MCP, 검증용).

## Global Constraints

- 단일 정적 `index.html`만 사용. 빌드 툴/프레임워크/외부 CDN 의존 금지.
- 브랜드 컬러 고정: 배경 `#FBF7F0`, 텍스트 `#3A322A`, 액센트 `#B5824D`, 뮤트 `#A39684`.
- 기본 언어 `ko`. 토글로 `en`. 기본 한국어 텍스트는 HTML에 그대로 존재(JS 꺼져도 한국어로 보임).
- 앱 카드 4개는 이름 + 한 줄 + `준비중 / Coming soon` 배지로 통일(스토어/웹 링크 없음).
- 연락처: `support@leoworks.kr`.
- 기존 개인정보처리방침 링크 2개(`./meongnyang-log/privacy/`, `./wordforage/privacy/`)는 푸터에 보존(상대경로 유지).
- 작업 브랜치 `feat/landing-page`에서 진행. `.DS_Store`는 커밋하지 않는다.
- 신규 파일명은 영문 kebab-case.

---

## File Structure

- `index.html` — (수정) 전체 랜딩 페이지. 구조 + CSS + i18n 토글 스크립트 한 파일에 포함.
- `CNAME` — (신규) GitHub Pages 커스텀 도메인 선언. 단일 줄 `leoworks.kr`.
- (변경 없음) `meongnyang-log/privacy/index.html`, `wordforage/privacy/index.html` — 푸터에서 계속 링크.

---

## Task 1: 한/영 포트폴리오 랜딩 페이지 (`index.html`)

**Files:**
- Modify: `index.html` (전체 교체)

**Interfaces:**
- Produces: 번역 대상 요소는 `data-ko`/`data-en` 속성을 가지며, 토글 버튼은 `data-lang-btn="ko|en"`. i18n 스크립트는 `localStorage.lang` + `?lang=` 쿼리를 읽어 `textContent`를 교체하고 `<html lang>`을 갱신한다. (Task 2/3에서 소비하지 않음 — 자기완결)

- [ ] **Step 1: `index.html`을 아래 내용으로 전체 교체**

```html
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LeoWorks</title>
<meta name="description" content="LeoWorks — 일상을 조금 더 낫게 만드는 모바일 앱을 만드는 스튜디오.">
<style>
  :root{
    --bg:#FBF7F0; --ink:#3A322A; --accent:#B5824D; --muted:#A39684;
    --card:#FFFFFF; --line:#EDE4D6;
  }
  *{box-sizing:border-box;}
  body{
    margin:0; background:var(--bg); color:var(--ink);
    font-family:-apple-system,BlinkMacSystemFont,"Apple SD Gothic Neo","Malgun Gothic",system-ui,sans-serif;
    line-height:1.6; -webkit-font-smoothing:antialiased;
  }
  a{color:var(--accent); text-decoration:none;}
  a:hover{text-decoration:underline;}
  .wrap{max-width:880px; margin:0 auto; padding:0 24px;}
  header.nav{display:flex; align-items:center; justify-content:space-between; padding:20px 0;}
  .brand{font-size:18px; font-weight:700; letter-spacing:.2px;}
  .lang-toggle{display:inline-flex; border:1px solid var(--line); border-radius:999px; overflow:hidden;}
  .lang-toggle button{
    appearance:none; border:0; background:transparent; color:var(--muted);
    font:inherit; font-size:13px; padding:6px 12px; cursor:pointer;
  }
  .lang-toggle button[aria-pressed="true"]{background:var(--accent); color:#fff;}
  .hero{padding:56px 0 40px; text-align:center;}
  .hero h1{font-size:40px; margin:0 0 12px; letter-spacing:.5px;}
  .hero p{font-size:18px; color:var(--muted); margin:0;}
  section{padding:32px 0;}
  h2{font-size:14px; text-transform:uppercase; letter-spacing:1.5px; color:var(--muted); margin:0 0 18px;}
  .grid{display:grid; grid-template-columns:repeat(2,1fr); gap:16px;}
  .card{
    background:var(--card); border:1px solid var(--line); border-radius:14px;
    padding:20px; display:flex; flex-direction:column; gap:8px;
  }
  .card .top{display:flex; align-items:center; justify-content:space-between;}
  .card .icon{font-size:28px;}
  .badge{
    font-size:11px; color:var(--accent); border:1px solid var(--accent);
    border-radius:999px; padding:2px 10px; white-space:nowrap;
  }
  .card h3{margin:4px 0 0; font-size:18px;}
  .card p{margin:0; color:var(--muted); font-size:14px;}
  .about p{font-size:16px; max-width:60ch;}
  .contact a{font-size:18px; font-weight:600;}
  footer{border-top:1px solid var(--line); margin-top:24px; padding:24px 0 40px; text-align:center;}
  footer .links{display:flex; gap:18px; justify-content:center; flex-wrap:wrap; margin-bottom:10px;}
  footer .copy{color:var(--muted); font-size:13px;}
  @media (max-width:600px){
    .grid{grid-template-columns:1fr;}
    .hero h1{font-size:32px;}
    .hero{padding:40px 0 28px;}
  }
</style>
</head>
<body>
<div class="wrap">

  <header class="nav">
    <div class="brand">LeoWorks</div>
    <div class="lang-toggle" role="group" aria-label="Language">
      <button type="button" data-lang-btn="ko" aria-pressed="true">KO</button>
      <button type="button" data-lang-btn="en" aria-pressed="false">EN</button>
    </div>
  </header>

  <main>
    <div class="hero">
      <h1>LeoWorks</h1>
      <p data-ko="일상을 조금 더 낫게 만드는 앱을 만듭니다"
         data-en="We build apps that make everyday life a little better">일상을 조금 더 낫게 만드는 앱을 만듭니다</p>
    </div>

    <section class="products">
      <h2 data-ko="제품" data-en="Products">제품</h2>
      <div class="grid">

        <article class="card">
          <div class="top">
            <span class="icon">🧘</span>
            <span class="badge" data-ko="준비중" data-en="Coming soon">준비중</span>
          </div>
          <h3 data-ko="Lessi" data-en="Lessi">Lessi</h3>
          <p data-ko="1:1 필라테스·골프 강사와 고객을 잇다"
             data-en="1:1 pilates & golf instructors, matched with clients">1:1 필라테스·골프 강사와 고객을 잇다</p>
        </article>

        <article class="card">
          <div class="top">
            <span class="icon">🐶</span>
            <span class="badge" data-ko="준비중" data-en="Coming soon">준비중</span>
          </div>
          <h3 data-ko="멍냥로그" data-en="Pawlog">멍냥로그</h3>
          <p data-ko="강아지·고양이의 하루를 기록하는 다이어리"
             data-en="A daily diary for your dog & cat">강아지·고양이의 하루를 기록하는 다이어리</p>
        </article>

        <article class="card">
          <div class="top">
            <span class="icon">🧩</span>
            <span class="badge" data-ko="준비중" data-en="Coming soon">준비중</span>
          </div>
          <h3 data-ko="낱말채집" data-en="WordForage">낱말채집</h3>
          <p data-ko="음절을 모아 한국어 단어를 만드는 퍼즐"
             data-en="A Korean word puzzle — collect syllables, build words">음절을 모아 한국어 단어를 만드는 퍼즐</p>
        </article>

        <article class="card">
          <div class="top">
            <span class="icon">🥾</span>
            <span class="badge" data-ko="준비중" data-en="Coming soon">준비중</span>
          </div>
          <h3 data-ko="오솔로그" data-en="Osolog">오솔로그</h3>
          <p data-ko="등산·러닝 코스를 발견하고 기록하다"
             data-en="Discover and track hiking & running trails">등산·러닝 코스를 발견하고 기록하다</p>
        </article>

      </div>
    </section>

    <section class="about">
      <h2 data-ko="소개" data-en="About">소개</h2>
      <p data-ko="LeoWorks는 일상에 쓰이는 모바일 앱을 만드는 1인 개발 스튜디오입니다."
         data-en="LeoWorks is a one-person studio crafting mobile apps for everyday life.">LeoWorks는 일상에 쓰이는 모바일 앱을 만드는 1인 개발 스튜디오입니다.</p>
    </section>

    <section class="contact">
      <h2 data-ko="문의" data-en="Contact">문의</h2>
      <a href="mailto:support@leoworks.kr">support@leoworks.kr</a>
    </section>
  </main>

  <footer>
    <div class="links">
      <a href="./meongnyang-log/privacy/" data-ko="멍냥로그 — 개인정보처리방침" data-en="Pawlog — Privacy Policy">멍냥로그 — 개인정보처리방침</a>
      <a href="./wordforage/privacy/" data-ko="낱말채집 — 개인정보처리방침" data-en="WordForage — Privacy Policy">낱말채집 — 개인정보처리방침</a>
    </div>
    <div class="copy">© 2026 LeoWorks</div>
  </footer>

</div>

<script>
  (function () {
    var KEY = 'lang';
    var params = new URLSearchParams(location.search);
    var lang = params.get('lang') || localStorage.getItem(KEY) || 'ko';
    if (lang !== 'en') lang = 'ko';
    function apply(l) {
      document.documentElement.lang = l;
      document.querySelectorAll('[data-ko]').forEach(function (el) {
        var t = (l === 'en') ? el.getAttribute('data-en') : el.getAttribute('data-ko');
        if (t !== null) el.textContent = t;
      });
      document.querySelectorAll('[data-lang-btn]').forEach(function (b) {
        b.setAttribute('aria-pressed', String(b.getAttribute('data-lang-btn') === l));
      });
      try { localStorage.setItem(KEY, l); } catch (e) {}
    }
    document.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-lang-btn]');
      if (btn) apply(btn.getAttribute('data-lang-btn'));
    });
    apply(lang);
  })();
</script>
</body>
</html>
```

- [ ] **Step 2: 구조 검증 (`rg`)**

Run:
```bash
cd /Users/leodev/apps/leoworks
rg -c 'data-ko=' index.html        # 번역 요소 수
rg -q 'support@leoworks.kr' index.html && echo OK-email
rg -q './meongnyang-log/privacy/' index.html && rg -q './wordforage/privacy/' index.html && echo OK-privacy
rg -q '1:1 필라테스' index.html && rg -q '강아지·고양이' index.html && rg -q '음절을 모아' index.html && rg -q '등산·러닝' index.html && echo OK-apps
```
Expected: `data-ko=` 카운트 ≥ 11, `OK-email`, `OK-privacy`, `OK-apps` 모두 출력.

- [ ] **Step 3: 동작 검증 (Playwright MCP)**

다음을 순서대로 실행(executor가 Playwright 접근 가능 시):
1. `browser_navigate` → `file:///Users/leodev/apps/leoworks/index.html`
2. `browser_snapshot` → 히어로에 "일상을 조금 더 낫게 만드는 앱을 만듭니다", 카드 4개(Lessi/멍냥로그/낱말채집/오솔로그)와 "준비중" 배지 4개 노출 확인.
3. `browser_click` → `EN` 버튼(`[data-lang-btn="en"]`).
4. `browser_snapshot` → 태그라인이 "We build apps that make everyday life a little better", 배지가 "Coming soon", 앱명이 Pawlog/WordForage/Osolog로 바뀌고, `EN` 버튼 `aria-pressed="true"` 확인.
5. `browser_navigate` → `file:///Users/leodev/apps/leoworks/index.html?lang=en` → 로드 즉시 영어 상태 확인(쿼리/persist 동작).

Expected: 위 모든 확인 통과. (Playwright 불가 환경이면 브라우저로 직접 열어 동일 항목 육안 확인.)

- [ ] **Step 4: 반응형 육안 확인**

브라우저 폭 600px 이하에서 카드 그리드가 1열로, 600px 초과에서 2열로 표시되는지 확인.

- [ ] **Step 5: Commit**

```bash
cd /Users/leodev/apps/leoworks
git add index.html
git commit -m "feat(landing): 한/영 토글 포트폴리오 랜딩 페이지

히어로·제품 4종(준비중 배지)·소개·문의(support@leoworks.kr) 섹션,
의존성 없는 vanilla JS 언어 토글(localStorage+?lang=), privacy 링크 보존.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 2: 커스텀 도메인 `CNAME` 파일

**Files:**
- Create: `CNAME`

**Interfaces:**
- Produces: 리포 루트 `CNAME` — GitHub Pages가 읽어 커스텀 도메인을 `leoworks.kr`로 설정. (Task 3의 DNS/Pages 검증이 이 파일에 의존)

- [ ] **Step 1: `CNAME` 파일 생성 (단일 줄, 도메인만)**

파일 `CNAME` 내용:
```
leoworks.kr
```

- [ ] **Step 2: 검증**

Run:
```bash
cd /Users/leodev/apps/leoworks
test "$(cat CNAME)" = "leoworks.kr" && echo OK-cname
```
Expected: `OK-cname`. (앞뒤 공백/추가 줄 없어야 함.)

- [ ] **Step 3: Commit**

```bash
cd /Users/leodev/apps/leoworks
git add CNAME
git commit -m "feat(pages): leoworks.kr 커스텀 도메인 CNAME 추가

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 3: 도메인 연결 + 배포 검증 (DNS · GitHub Pages)

> 이 태스크는 **등록처 콘솔/GitHub 설정**(사용자 권한 영역)과 **에이전트 검증**(dig/curl)이 섞인다. 사용자 액션 단계는 `(사용자)`로 표기.

**Files:** 없음(설정 작업). 선행: Task 1·2가 `feat/landing-page`에 커밋되어 있고, **`main`에 병합되어 GitHub에 푸시**되어야 Pages가 반영됨.

- [ ] **Step 1: 브랜치 병합 & 푸시**

```bash
cd /Users/leodev/apps/leoworks
git checkout main
git merge --no-ff feat/landing-page -m "merge: LeoWorks 랜딩 + leoworks.kr 도메인"
git push origin main
```
Expected: 푸시 성공. (사용자가 PR 방식을 원하면 대신 `git push origin feat/landing-page` 후 GitHub에서 PR 머지.)

- [ ] **Step 2: `(사용자)` 등록처 DNS 설정**

도메인 등록처(가비아/후이즈 등) DNS 관리에서 `leoworks.kr`에 추가:
- **A 레코드 4개** (host: `@` / apex):
  `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
- (선택) **AAAA 4개**: `2606:50c0:8000::153`, `2606:50c0:8001::153`, `2606:50c0:8002::153`, `2606:50c0:8003::153`
- (선택) **CNAME** host `www` → `illee.github.io`

- [ ] **Step 3: `(사용자)` GitHub Pages 커스텀 도메인 확인**

GitHub repo → Settings → Pages → Custom domain이 `leoworks.kr`로 채워졌는지 확인(Step 1에서 `CNAME` 푸시 시 자동 설정됨). DNS 전파 후 **Enforce HTTPS** 체크.

- [ ] **Step 4: DNS 전파 검증 (에이전트)**

Run:
```bash
dig +short leoworks.kr
```
Expected: `185.199.108.153`~`185.199.111.153` 4개 IP 출력. (안 나오면 전파 대기 — 수십 분~수 시간.)

- [ ] **Step 5: HTTPS·콘텐츠 검증 (에이전트)**

Run:
```bash
curl -sS -o /dev/null -w "%{http_code}\n" https://leoworks.kr/
curl -sS https://leoworks.kr/ | rg -q 'LeoWorks' && echo OK-landing
curl -sS -o /dev/null -w "privacy1=%{http_code}\n" https://leoworks.kr/meongnyang-log/privacy/
curl -sS -o /dev/null -w "privacy2=%{http_code}\n" https://leoworks.kr/wordforage/privacy/
```
Expected: 루트 `200`, `OK-landing`, `privacy1=200`, `privacy2=200`. (인증서 발급 전이면 SSL 오류 → Enforce HTTPS 발급 대기.)

- [ ] **Step 6: 완료 보고**

`leoworks.kr` 200/HTTPS + privacy 링크 정상 확인 후, 애플·구글 법인 심사에 회사 사이트로 사용 가능함을 사용자에게 보고.

---

## Self-Review

**1. Spec coverage**
- 범위(포트폴리오 랜딩) → Task 1 ✓ · 한/영 토글 → Task 1(스크립트+data-en) ✓ · 앱 카드 4개+준비중 → Task 1 ✓ · 연락처 support@ → Task 1 ✓ · privacy 보존 → Task 1 footer ✓ · CNAME → Task 2 ✓ · DNS/Pages/HTTPS → Task 3 ✓ · DoD(반응형·토글·배포 검증) → Task 1 Step3-4 / Task 3 Step4-5 ✓ · 브랜드 컬러 → Task 1 CSS `:root` ✓.
- 갭 없음.

**2. Placeholder scan**: TBD/TODO/"적절히 처리" 류 없음. 모든 코드/명령 실제값. 앱 아이콘 이모지는 스펙상 의도된 임시값(범위 밖에 명시).

**3. Type consistency**: 토글 속성 일관 — `data-ko`/`data-en`/`data-lang-btn`이 HTML과 스크립트에서 동일하게 사용. `localStorage` key `lang` 일관. CNAME 값 `leoworks.kr` 일관(Task 2·3).
