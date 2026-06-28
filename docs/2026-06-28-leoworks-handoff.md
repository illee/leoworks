# LeoWorks 운영 핸드오프 — 2026-06-28 (자기완결)

> 관점: 다음 세션에서 이 파일로 맥락 복원. 직전 상태는 [`2026-06-25-leoworks-handoff.md`](2026-06-25-leoworks-handoff.md), 전체 히스토리는 [`2026-06-24-leoworks-handoff.md`](2026-06-24-leoworks-handoff.md).
> 한 줄: leoworks.kr HTTPS 라이브 유지. **06-25 이후 = 게임 개인정보처리방침 3종 게시(스도쿠·네모로직) + 캐주얼 게임란 3종으로 확장 + 문의 섹션 폰트 축소.** 추가로 3번째 게임(하루 네모로직) 기획 확정 + Play 제출 자동화 키트 작성(bizdev 허브).

---

## 0. 현재 상태 (한눈에)
| 영역 | 상태 |
|---|---|
| 회사 사이트 `leoworks.kr` | ✅ HTTPS 라이브. **캐주얼 게임 3종(낱말채집·하루 스도쿠·하루 네모로직) + 정책 4종 푸터 링크 + 문의 폰트 축소 배포(라이브 검증 OK)** |
| 개인정보처리방침 | ✅ 멍냥로그·낱말채집·**하루 스도쿠**·**하루 네모로직** 4종 게시. URL = `https://leoworks.kr/<app>/privacy/` |
| 도메인/HTTPS/메일 | ✅ 완료(06-24). dev@/support@ → Gmail 포워딩(ImprovMX) |
| Google Play 조직 계정 | 🔄 오늘 사용자가 Play Console **앱 설정(개인정보처리방침·데이터 보안 등) 진행** → 앱 등록/설정 가능 상태로 진전된 것으로 보임(직전 핸드오프 "전화번호 인증 잠김"에서 변화). **정확한 계정 상태는 Play Console에서 확인 권장.** |
| Apple Developer | ⏳ 미착수 |

## 1. 06-25 이후 한 일 — 사이트
**가. 게임 개인정보처리방침 게시 (2종 신규)**
- **하루 스도쿠**: `haru-sudoku/privacy/index.html` 생성 + 푸터 링크. (낱말채집 정책 템플릿 적응 — Flutter 게임·AdMob·무광고 IAP·오프라인·로컬 저장.) 커밋 `0bb0769`(정책)·`e0189b3`(푸터).
- **하루 네모로직**: `haru-picross/privacy/index.html` 생성 + 푸터 링크. (스도쿠 정책과 동일 데이터 프로필.) 시행일 2026-06-28.
- 4종 정책 모두 라이브 200. Play Console 개인정보처리방침 URL로 그대로 사용 가능.

**나. 캐주얼 게임란 확장 (2종 → 3종)**
- `하루 네모로직(Haru Picross)` 카드 추가. **사용자가 실제 스토어 아이콘 제공** → `assets/haru-picross.png`(주황 라운드 + 점-그리드, 네모로직 모티프).
- 게임 그리드 `grid two`(2열) → `grid`(3열)로 변경 → 제품 3종과 동일하게 게임 3종 3-up 정렬. 모바일 1열 반응형 유지.

**다. 문의 섹션 폰트 축소**
- "함께 이야기해요" 헤드라인 `clamp(24px,4vw,32px)` → `clamp(19px,2.6vw,24px)`.
- 이메일 `clamp(20px,3vw,26px)/800` → `clamp(15px,2vw,18px)/700`.
- (eyebrow "문의" 13px는 전 섹션 공통이라 유지.)
- 커밋 `f357818`(나·다 + 네모로직 정책 일괄). gitleaks 통과, `.DS_Store` 제외.

## 2. 다음 액션
- ⏳ **하루 스도쿠 실제 런처 아이콘** 생성(`sudoku-mb-2606` — 홈은 아직 SVG 재현본). 네모로직은 실제 스토어 아이콘 확보됨.
- ⏳ **이름 확정**: "하루 네모로직 / Haru Picross"는 가칭 → 출시 전 **상표(KIPRIS)·도메인·스토어 충돌** 확인. 확정 시 표기/경로(`/haru-picross/`) 변경 가능.
- ⏳ Play Console: 각 게임 데이터 보안 설문은 정책과 일치(AdMob 4종만 신고) — `ref/2026-06-28-leoworks-play-submission-kit.md` §4 진리표 사용.

## 3. 연관 — bizdev 기획 허브 산출물 (별도, `~/apps/bizdev/ref/`)
- **3번째 캐주얼 게임 확정(2026-06-27)**: 하루 네모로직(네모로직/Picross). 근거·설계·하이브리드 생성 = `2026-06-27-nonogram-picross-handoff.md`. 강자 Easybrain `Nonogram.com`(4.43★/79만)의 광고과다·재탕 불만 정조준.
- **LeoWorks Play 제출 키트(2026-06-28)**: `2026-06-28-leoworks-play-submission-kit.md` — fastlane supply + CI로 릴리스 자동화, 데이터 보안 CSV·콘텐츠 등급 답안지 재사용. (앱 생성·콘텐츠 등급은 수동.)
- 캐주얼 게임 트랙: 낱말채집(단어)→하루 스도쿠(숫자)→하루 네모로직(그림). 빌드·배포는 각 게임 프로젝트 세션에서.

## 4. 핵심 사실 (빠른 참조)
- repo `github.com/illee/leoworks` · Pages `main`/`(root)` · `leoworks.kr`(가비아) · 내부문서 비공개(`_config.yml exclude: docs/`).
- 이메일: support@leoworks.kr(공개) · dev@leoworks.kr — ImprovMX → leodev19lee@gmail.com
- 홈페이지: 제품 Lessi(라이브)·멍냥로그·오솔로그 + 캐주얼 게임 낱말채집·하루 스도쿠·하루 네모로직
- 정책 4종: `/meongnyang-log/privacy/` · `/wordforage/privacy/` · `/haru-sudoku/privacy/` · `/haru-picross/privacy/`
- 게임 데이터 프로필(스도쿠·네모로직 동일): 오프라인·서버없음·계정없음·로컬(Hive) 저장, 외부=AdMob+Google Play IAP만.

> 작성: Claude Code · 2026-06-28. 다음 세션: §0 → §2(아이콘·이름·Play 설정) 확인.
