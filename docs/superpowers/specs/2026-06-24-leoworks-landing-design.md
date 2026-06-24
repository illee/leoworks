# LeoWorks 랜딩 페이지 + leoworks.kr 연결 — 설계 (Design Spec)

> 작성일: 2026-06-24 · 상태: 설계 확정(구현 전) · 리포: `illee/leoworks` (GitHub Pages)
> 목적: 기존 최소 랜딩(개인정보처리방침 허브)을 **회사 포트폴리오 랜딩**으로 확장하고, 구매한 **leoworks.kr** 커스텀 도메인을 연결한다. 부차 목적: 애플·구글 법인 계정 심사가 요구하는 "실제 작동하는 회사 사이트" 요건 충족.

---

## 1. 배경 / 현재 상태

- 리포 `github.com/illee/leoworks` 가 이미 존재하고 GitHub Pages로 운영 중.
- 현재 `index.html` = 최소 랜딩(LeoWorks 제목 + 멍냥로그·낱말채집 개인정보처리방침 링크 2개). 브랜드 컬러 이미 적용: 크림 `#FBF7F0` / 브라운 `#B5824D` / 텍스트 `#3A322A`.
- 하위 경로 `meongnyang-log/privacy/`, `wordforage/privacy/` 에 개인정보처리방침 페이지 존재(상대 링크).
- `leoworks.kr` 도메인 구매 완료, **아직 미연결**(CNAME 파일 없음).
- LeoWorks가 운영하는 4개 앱: Lessi, 멍냥로그(Pawlog), 낱말채집(WordForage), 오솔로그(Osolog) — **전부 스토어 출시 전(개발 중)**.

## 2. 요구사항 (확정)

- **범위**: 제품 포트폴리오 본격 랜딩 1페이지(앱 카드 4개 포함).
- **언어**: 한/영 토글 전환(기본 한국어).
- **앱 카드**: 이름 + 한 줄 설명 + `준비중 / Coming soon` 배지로 통일(스토어/웹 링크 없음 — 출시 시 추가).
- **연락처**: `support@leoworks.kr`.
- **도메인**: `leoworks.kr` 를 GitHub Pages 커스텀 도메인으로 연결(HTTPS).
- **기존 자산 보존**: 개인정보처리방침 링크 2개는 푸터에 유지(애플/구글 제출 URL).

## 3. 기술 접근 (확정: 순수 정적 HTML)

- **단일 `index.html`** 을 확장. 손수 작성한 CSS + 의존성 없는 vanilla JS(언어 토글). **빌드 단계 없음.**
- 사유: 기존 리포 스타일과 일치, 의존성 0, 단순 랜딩에 최적(YAGNI). Astro 등 SSG / Tailwind CDN은 과함이라 채택하지 않음.
- 기존 브랜드 컬러 유지.

## 4. 페이지 구조 (단일 `index.html`)

```
[상단바]  LeoWorks 워드마크                         [KO | EN] 토글
[히어로]  LeoWorks
          일상을 조금 더 낫게 만드는 앱을 만듭니다
[Products] 4개 카드 (데스크톱 2×2 그리드, 모바일 1열)
          - Lessi      / 준비중 / 1:1 강사 ↔ 고객 연결
          - 멍냥로그    / 준비중 / 강아지·고양이 일상 다이어리
          - 낱말채집    / 준비중 / 음절로 만드는 한국어 단어 퍼즐
          - 오솔로그    / 준비중 / 등산·러닝 코스 발견·기록
[About]   한 단락 회사 소개(1인 개발 스튜디오)
[Contact] support@leoworks.kr
[Footer]  Privacy: 멍냥로그 / 낱말채집  ·  © 2026 LeoWorks
```

- 앱 아이콘: 실제 아이콘 미정 → 이모지/모노그램으로 임시 처리, 출시 시 교체.
- 반응형: 모바일 1열, 태블릿·데스크톱 2열. 시스템 폰트 스택(기존 유지).

## 5. 콘텐츠 (한/영)

| 항목 | 한국어 | English |
|---|---|---|
| 태그라인 | 일상을 조금 더 낫게 만드는 앱을 만듭니다 | We build apps that make everyday life a little better |
| Lessi | 1:1 필라테스·골프 강사와 고객을 잇다 | 1:1 pilates & golf instructors, matched with clients |
| 멍냥로그 | 강아지·고양이의 하루를 기록하는 다이어리 | A daily diary for your dog & cat |
| 낱말채집 | 음절을 모아 한국어 단어를 만드는 퍼즐 | A Korean word puzzle — collect syllables, build words |
| 오솔로그 | 등산·러닝 코스를 발견하고 기록하다 | Discover and track hiking & running trails |
| About | LeoWorks는 일상에 쓰이는 모바일 앱을 만드는 1인 개발 스튜디오입니다. | LeoWorks is a one-person studio crafting mobile apps for everyday life. |
| 배지 | 준비중 | Coming soon |

> 문구는 구현 중 미세 조정 가능. 의미·톤은 위 표를 기준선으로 한다.

## 6. 한/영 토글 메커니즘

- 번역 대상 요소에 `data-ko` / `data-en` 속성 부여. 작은 JS가 `lang` 상태에 따라 `textContent` 교체 + `document.documentElement.lang` 갱신.
- 선택값 `localStorage`(key: `lang`) 저장. URL `?lang=en` 쿼리도 지원. 기본값 **ko**.
- **기본 한국어 텍스트는 HTML에 그대로 렌더**(JS 비활성/크롤러에서도 한국어로 보임 → SEO·접근성).
- 의존성 없는 ~20줄 스크립트.

## 7. leoworks.kr 도메인 연결

1. 리포 루트에 **`CNAME` 파일** 추가 → 내용: `leoworks.kr` (구현 단계에서 처리).
2. **도메인 등록처 DNS 설정**(사용자가 등록처 콘솔에서 직접):
   - **A 레코드 4개** (apex `leoworks.kr` → GitHub Pages):
     `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - (선택) **AAAA 4개**(IPv6): `2606:50c0:8000::153`, `2606:50c0:8001::153`, `2606:50c0:8002::153`, `2606:50c0:8003::153`
   - (선택) **CNAME** `www` → `illee.github.io`
3. **GitHub repo → Settings → Pages → Custom domain** 에 `leoworks.kr` 입력 → DNS 전파 후 **Enforce HTTPS** 체크(인증서 자동 발급).

> 등록처 콘솔/깃허브 설정 화면은 사용자 권한 영역 → 구현 단계에서 화면 보며 함께 진행. 코드 측 작업은 `CNAME` 파일 추가뿐.

## 8. 검증 (Definition of Done)

- 로컬에서 `index.html` 열어: 한/영 토글 동작, 4개 카드 레이아웃, 모바일/데스크톱 반응형, 푸터 privacy 링크 확인.
- 배포 후: `https://leoworks.kr` 200 + HTTPS 유효, `www`(설정 시) 정상, 기존 `https://leoworks.kr/meongnyang-log/privacy/` · `/wordforage/privacy/` 정상 로드.
- 심사 관점: 회사명·하는 일·제품 4종·연락처가 한 화면 흐름에서 명확히 노출.

## 9. 범위 밖 (Out of scope)

- 앱별 상세 페이지 / 스토어·다운로드 링크(출시 후).
- 블로그·뉴스·채용 등 추가 섹션.
- 분석(GA 등)·문의 폼 백엔드.
- 실제 앱 아이콘 디자인(임시 표기로 대체).
- 메일 서버 구축(도메인 등록처의 메일 포워딩으로 `support@leoworks.kr` 수신 — 사이트 코드와 무관).

## 10. 리스크 / 주의

- **DNS 전파 지연**: 커스텀 도메인 HTTPS 인증서 발급까지 수십 분~수 시간. Enforce HTTPS는 인증서 발급 후 체크.
- **apex vs www**: apex(`leoworks.kr`)는 A 레코드 필수(CNAME 불가). www만 CNAME 가능.
- **프로젝트 페이지 경로**: 현재 `illee.github.io/leoworks/` 형태일 수 있음 → 커스텀 도메인 연결 시 루트로 서빙. 내부 링크가 상대경로라 양쪽 모두 정상 동작.
- **메일 포워딩 선행 권장**: 애플·구글 심사가 회사 도메인 이메일을 요구하므로 `support@leoworks.kr` 수신을 등록처 포워딩으로 먼저 세팅.
