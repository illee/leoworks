# LeoWorks 사이트·도메인 핸드오프 — 2026-06-24 (자기완결)

> 상태: **✅ 완료 — `https://leoworks.kr` 풀 라이브(HTTPS·http→https 리다이렉트 적용).** 인증서는 2026-06-24 익일 네거티브 캐시 만료 후 자동 발급됨.
> 한 줄: LeoWorks 회사 랜딩을 `leoworks.kr`에 GitHub Pages로 배포 + 커스텀 도메인 + HTTPS까지 완료. 메일은 ImprovMX로 dev@/support@ → Gmail 포워딩(DNS 검증 완료).

---

## 0. 핵심 요약 (먼저 읽기)
- **무엇**: LeoWorks(개발사) 공식 랜딩 + 4개 앱 소개 + 개인정보처리방침 허브. 애플·구글 법인 계정 심사가 요구하는 "작동하는 회사 사이트" 겸용.
- **어디**: repo `github.com/illee/leoworks` (GitHub Pages, `main` 브랜치 `/root`), 도메인 `leoworks.kr`(가비아 구매).
- **지금 상태**: ✅ `https://leoworks.kr` 200, http→301→https 리다이렉트, privacy 2종 https 200. Enforce HTTPS ON. **완전 라이브.**
- **메일**: ImprovMX로 dev@/support@leoworks.kr → leodev19lee@gmail.com 포워딩. MX(mx1/mx2.improvmx.com)+SPF DNS 검증 완료(웹 A레코드 무영향).

---

## 1. 오늘(2026-06-24) 한 일
- LeoWorks **한/영 토글 포트폴리오 랜딩** `index.html` 신규 작성(브레인스토밍→스펙→계획→서브에이전트 구동 구현·리뷰).
  - 히어로 + 앱 카드 4종(**Lessi·멍냥로그·낱말채집·오솔로그**, 각 "준비중/Coming soon" 배지) + 소개 + 문의 + 푸터(privacy 링크 보존).
  - 브랜드 컬러: 크림 `#FBF7F0` / 텍스트 `#3A322A` / 액센트 `#B5824D`. 의존성 0(순수 정적 + vanilla JS 토글, `localStorage`+`?lang=`).
- `CNAME`(`leoworks.kr`) 추가 → GitHub Pages 커스텀 도메인 자동 설정.
- `_config.yml`로 `docs/` **Pages 퍼블리시 제외**(이 핸드오프·스펙·계획은 리포엔 보존, 공개 사이트엔 노출 안 됨).
- canonical 링크 추가(`https://leoworks.kr/`) — github.io↔커스텀 도메인 중복 인덱싱 방지.
- 가비아 DNS A레코드 4개 연결 → 사이트 라이브(HTTP). 코드 리뷰 최종 **Ship**.

**오늘 커밋(main):** `a5ef68e`(스펙) · `4f8a438`(계획) · `51926d7`(랜딩) · `0b1bcab`(CNAME) · `790d9e8`(merge) · `15909e7`(_config) · `d498fbc`(canonical+CNAME개행) · `8c8c248`/`f561947`(도메인 remove/re-add 넛지).

---

## 2. 현재 상태 (배포)
| 항목 | 상태 |
|---|---|
| 랜딩 페이지 | ✅ 완료·리뷰·배포 |
| `leoworks.kr` DNS | ✅ A레코드 4개 정상(8.8.8.8/1.1.1.1 일치, NS=gabia) |
| 사이트 | ✅ `https://leoworks.kr` 200, http→301→https, privacy 2종 https 200 |
| HTTPS 인증서 | ✅ 발급 완료(`cert.state: approved`) — 네거티브 캐시 만료 후 자동 |
| Enforce HTTPS | ✅ ON (`https_enforced: true`) |
| 메일 포워딩 | ✅ ImprovMX MX+SPF DNS 검증 완료(dev@/support@ → Gmail). 실수신 테스트는 사용자 확인 권장 |

---

## 3. ⚠️ HTTPS가 아직 안 되는 진짜 이유 (근본 원인 — 중요)
**DNS 네거티브 캐시.** 순서가 이랬다:
1. CNAME 푸시 → GitHub이 도메인 설정하고 즉시 DNS 검사 시작.
2. **그 시점엔 가비아 A레코드가 아직 없었음** → GitHub 리졸버가 "leoworks.kr 레코드 없음"을 받음.
3. 가비아 존 **SOA minimum = 86400초(24시간)** → GitHub 리졸버가 이 "없음"을 **최대 24h 캐시**.
4. 이후 A레코드를 넣어도 GitHub은 캐시 만료 전까지 옛 결과만 봄 → GitHub UI **"DNS Check in Progress"** 고착, 인증서 발급 보류.

**시사점:**
- **remove/re-add·재빌드로 안 풀린다**(리졸버 캐시는 그걸로 안 비워지고, GitHub측 타이머만 리셋됨). 더 건드리지 말 것.
- 외부에서 남의 리졸버 캐시를 강제 flush할 방법 없음 → **시간 경과만이 해결**(최대 24h, 보통 밤사이 자동 해소).
- DNS/CAA(없음)/AAAA(없음)/도메인검증/HTTP 서빙은 **전부 정상** — 설정 문제 아님.

---

## 4. 다음에 돌아오면 (마무리 절차, 1분)
1. 확인: `gh api repos/illee/leoworks/pages --jq '.https_certificate.state'` 가 `issued` 인지, 또는 `curl -I https://leoworks.kr` 200 인지.
   - GitHub UI: Settings→Pages에서 **Enforce HTTPS 체크박스가 활성화**되면 발급 완료 신호.
2. **Enforce HTTPS 켜기**: `gh api -X PUT repos/illee/leoworks/pages -F https_enforced=true` (또는 UI 체크박스).
3. 검증: `curl -sI http://leoworks.kr`(→301 https 리다이렉트), `curl -sI https://leoworks.kr`(200), privacy 2종 https 200.
4. 끝 → 사용자 보고. (`.superpowers/sdd/progress.md`의 Task 3 완료 마킹)
- 만약 **24h 지나도 발급 안 되면**: GitHub Support 문의(스택: Pages 커스텀 도메인 cert stuck at "will begin shortly", DNS는 정상). 또는 가비아에서 A레코드 재확인.

---

## 5. 연관 작업 — 애플/구글 법인 계정 등록 (이 사이트의 목적 중 하나)
- **DUNS 번호 발급 완료**(2026-06-24). 이제 법인 계정 등록 가능.
- **Apple Developer Program**(Organization, $99/년): DUNS + **회사 도메인 이메일**(support@leoworks.kr) + **작동하는 회사 웹사이트**(leoworks.kr) + 전화 검증(D&B 등록 번호로 콜 올 수 있음) 필요. DUNS 발급 후 2영업일 propagation 대기 권장.
- **Google Play**(조직 계정, $25 1회): DUNS 정확히 입력 시 자동검증 가능. 2026년 개발자 신원검증 강화(시행 9월, 한국은 1차 아님).
- **거절 방지 핵심**: 법인명(영문) DUNS와 완전 일치, D&B 전화 수신 가능, 회사 도메인 이메일, 작동하는 회사 사이트. → **사이트(leoworks.kr)는 HTTP로도 이미 요건 충족** → 등록은 HTTPS 기다리지 말고 진행 가능.

---

## 6. 핵심 사실 (빠른 참조)
- repo: `github.com/illee/leoworks` · Pages: `main`/`(root)` · 도메인: `leoworks.kr`(가비아, A레코드 GitHub Pages 4개)
- 회사 이메일(심사·문의): **support@leoworks.kr** (가비아 메일 포워딩으로 수신 세팅 권장 — 아직 확인 필요)
- 패키지 컨벤션: `com.leoworks.*` · 앱 4종: Lessi / 멍냥로그(Pawlog) / 낱말채집(WordForage) / 오솔로그(Osolog) — 전부 스토어 출시 전
- 내부 문서(비공개): `docs/superpowers/specs|plans/` + 이 핸드오프. SDD 진행 원장: `.superpowers/sdd/progress.md`

> 작성: Claude Code · 2026-06-24. 다음 세션은 이 파일 §4부터 보면 1분에 마무리됩니다.
