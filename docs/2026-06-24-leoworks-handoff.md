# LeoWorks 운영 핸드오프 — 2026-06-24 (자기완결, 하루 종합)

> 관점: 다음 세션에서 이 파일 하나로 맥락이 복원되도록 자기완결.
> 한 줄: **회사 사이트·도메인·HTTPS·도메인 메일은 전부 완료.** 남은 핵심은 **Google Play 조직 계정의 "조직 서류(D-U-N-S) 승인 대기"**(이게 끝나야 전화번호 인증이 열림). Apple 등록은 준비 끝, 미착수.

---

## 0. 현재 상태 (한눈에)

| 영역 | 상태 |
|---|---|
| 회사 사이트 `leoworks.kr` | ✅ **HTTPS 라이브** — 현대적 리디자인, 제품 3종+로고 |
| 도메인/DNS (가비아) | ✅ A레코드 4개(GitHub Pages) + MX/SPF(ImprovMX) |
| HTTPS | ✅ 인증서 발급 + Enforce HTTPS ON, http→301→https |
| 도메인 메일 | ✅ dev@/support@leoworks.kr → Gmail 포워딩(ImprovMX), DNS 검증 — *실수신 테스트만 남음* |
| **Google Play 조직 계정** | 🔄 가입·본인·사이트 인증 완료 / **조직 D-U-N-S 서류 구글 승인 대기 → 전화번호 인증 잠김** ← 다음 세션 핵심 |
| Apple Developer | ⏳ 미착수 (필요 요건 DUNS·사이트·도메인 이메일 전부 준비됨) |
| /watch 영상 분석 | ⏸ 보류 (yt-dlp 설치됨, Whisper 키 없음) |

---

## 1. 회사 사이트 (완료)
- repo `github.com/illee/leoworks`, GitHub Pages `main`/`(root)`, 도메인 `leoworks.kr`.
- **리디자인 배포**(commit `ae3106d`): 스티키 nav(KO/EN 토글)·히어로·호버 카드·소개/문의 섹션, 따뜻한 팔레트, favicon(L 모노그램).
- **제품 3종**: **Lessi**(→ `lessi.co.kr` 링크) · **멍냥로그** · **오솔로그**(둘 다 "Google Play·App Store 출시 예정" 배지). 각 제품 **로고** = `assets/lessi.png`·`pawlog.png`·`osolog.png`. 상세 설명 한/영.
  - 낱말채집(WordForage)은 **제품 쇼케이스에서 제외**(앱은 존재). 푸터 privacy 링크(멍냥로그·낱말채집)는 보존.
- 내부 문서는 `_config.yml`의 `exclude: [docs/]`로 공개 사이트에서 제외(리포엔 보존).
- 향후: 멍냥로그·오솔로그 스토어 출시 시 "출시 예정" 배지 → 스토어 다운로드 링크로 교체(1분 작업).

## 2. 도메인 · HTTPS · 메일 (완료)
- **DNS(가비아)**: A `@` → `185.199.108~111.153`(GitHub Pages). MX `mx1.improvmx.com`(10)·`mx2.improvmx.com`(20). TXT SPF `v=spf1 include:spf.improvmx.com ~all`. (NS = gabia, 그대로 유지)
- **HTTPS**: Enforce ON(`https_enforced: true`).
- **메일**: ImprovMX 무료 — dev@/support@leoworks.kr → `leodev19lee@gmail.com` 포워딩. *남은 것: 실제로 메일 보내 Gmail 도착 확인.*
- ⚠️ **학습(중요)**: HTTPS 인증서가 ~3.5h "DNS Check in Progress"로 멈췄던 원인 = **DNS 네거티브 캐시**(가비아 존 SOA minimum **86400s/24h**). 도메인을 GitHub에 먼저 붙이고 A레코드를 나중에 넣으면 GitHub 리졸버가 "레코드 없음"을 24h 캐시함. **remove/re-add·재빌드로 안 풀림(시간만 해결).** → 다음 도메인은 **A레코드 먼저 넣고** 커스텀 도메인 설정할 것.

## 3. ⭐ Google Play 조직 계정 (진행 중 — 다음 세션 1순위)
- **계정**: `leodev19` (조직 계정), 계정 ID `7030892794390540993`. **로그인 = `leodev19lee@gmail.com`**(개인 Gmail로 가입 — 조직 검증은 DUNS로 하므로 무관). **연락처 이메일 = `dev@leoworks.kr`(✅ 확인됨)**, 연락처 전화 `+82 70-7954-2421`.
- **완료**: 가입, 본인(신원) 인증, 웹사이트 인증.
- **막힌 것**: 전화번호 인증 시 *"이 전화번호를 인증하려면 먼저 다른 인증 작업을 완료하세요 … Google에서 서류를 승인받는…"* → 원인 = **조직 D-U-N-S/사업자 서류를 구글이 아직 승인하지 않음.** 전화번호는 마지막 단계라 그게 승인돼야 열림.
- **어디서 확인**: Play Console 홈 → **`세부정보 보기`** → 계정 세부정보의 **`내 정보` 탭**(조직 정보·D-U-N-S·서류 인증 상태). + 우상단 **🔔 알림** + **dev@leoworks.kr 메일**(구글이 승인/추가요청을 여기로 보냄).
- **다음 액션**:
  - "내 정보" 탭의 조직 인증이 **"검토 중"** 이면 → **기다리기**(보통 며칠). 승인되면 전화번호 인증 자동 해제.
  - **"조치 필요"** 면 → D-U-N-S 입력 확인 + **법인명이 DUNS(D&B)=사업자등록증과 정확히 일치**하는지 + 요청 서류(사업자등록증) 제출.
  - 승인 후: 전화번호 인증을 **연락처 전화번호 + 개발자 전화번호 둘 다** 완료(SMS/통화 코드).
- 💡 **070 번호 주의**: `070-7954-2421`은 인터넷전화 → SMS/자동전화 수신이 안 될 수 있음. 코드 안 오면 **휴대폰 번호로** 교체해 시도.

## 4. Apple Developer Program (미착수 · 준비 완료)
- Organization, $99/년. **필요 요건 전부 준비됨**: D-U-N-S, 작동하는 회사 사이트(`https://leoworks.kr`), 회사 도메인 업무 이메일(`dev@`/`support@leoworks.kr`).
- 거절 방지: **법인명(영문) DUNS와 정확 일치**, D&B 등록 전화 수신 가능(검증 콜 올 수 있음), 회사 도메인 이메일, 작동 사이트. DUNS 발급 후 D&B↔Apple 동기화 2영업일 권장.

## 5. 기타 / 파킹
- **/watch (영상 분석 스킬)**: yt-dlp 설치 완료, Whisper API 키 없음(`~/.config/watch/.env` 스캐폴드됨). 재개: 영상 URL 주면 자막 모드(`--no-whisper`)로 진행, 또는 Groq/OpenAI 키 추가 시 자막 없는 영상도 전사.

## 6. 핵심 사실 (빠른 참조)
- repo `github.com/illee/leoworks` · Pages `main`/`(root)` · 도메인 `leoworks.kr`(가비아)
- 회사 이메일: **support@leoworks.kr**(공개/문의), **dev@leoworks.kr**(구글 연락처) — 둘 다 ImprovMX로 `leodev19lee@gmail.com` 포워딩
- 패키지 컨벤션 `com.leoworks.*` · 앱: Lessi(라이브, lessi.co.kr) / 멍냥로그(Pawlog) / 오솔로그(Osolog) / 낱말채집(WordForage) — 멍냥·오솔·낱말은 스토어 출시 전
- 내부 문서(비공개): `docs/superpowers/specs|plans/` · SDD 원장 `.superpowers/sdd/progress.md` · 이 핸드오프 `docs/2026-06-24-leoworks-handoff.md`

> 작성: Claude Code · 2026-06-24. 다음 세션은 §0(현재 상태) → §3(Google Play, 1순위) 순으로 보면 즉시 복귀됩니다.
