# LeoWorks 운영 핸드오프 — 2026-06-25 (자기완결)

> 관점: 다음 세션에서 이 파일로 맥락 복원. 전체 히스토리(사이트 구축·도메인·HTTPS·메일·Google Play)는 [`2026-06-24-leoworks-handoff.md`](2026-06-24-leoworks-handoff.md) 참조.
> 한 줄: 회사 사이트(leoworks.kr) **HTTPS 라이브 + 메일 포워딩 완료** 상태 유지. 오늘 = **홈페이지에 캐주얼 게임 블럭(낱말채집·하루 스도쿠) 추가·배포 완료(라이브)**.

---

## 0. 현재 상태 (한눈에)
| 영역 | 상태 |
|---|---|
| 회사 사이트 `leoworks.kr` | ✅ HTTPS 라이브. **오늘 캐주얼 게임 블럭 추가·배포 완료(라이브 검증 OK)** |
| 도메인/HTTPS/메일 | ✅ 완료(06-24). dev@/support@ → Gmail 포워딩(ImprovMX) |
| Google Play 조직 계정 | 🔄 변동 없음 — **조직 D-U-N-S 서류 구글 승인 대기 → 전화번호 인증 잠김** (다음 행동: Play Console "내 정보" 탭 상태 확인) |
| Apple Developer | ⏳ 미착수(요건 준비됨) |

## 1. 오늘(2026-06-25) 한 일 — 홈페이지 캐주얼 게임 블럭
- 기존 3개 제품(Lessi·멍냥로그·오솔로그) **하단에 구분선 + "가볍게 즐기는 두뇌 퍼즐" 서브섹션** 신설.
- 게임 2종 추가:
  - **낱말채집(WordForage)** — 정식 앱 아이콘 `assets/wordforage.png`(낱·말 크로스워드).
  - **하루 스도쿠(Haru Sudoku)** — `assets/haru-sudoku.svg`. ⚠️ 스도쿠 앱의 *실제 런처 아이콘은 아직 Flutter 기본*이라, Soft Pop 디자인 핸드오프의 아이콘 명세(민트 3×3 + 코랄 중앙셀 "5")를 **SVG로 재현**해 사용. → 나중에 스도쿠 프로젝트에서 동일 디자인으로 실제 런처 아이콘 생성 권장.
  - 각 "Google Play 출시 예정" 배지, 한/영 토글, 데스크톱 2열 → 모바일 1열 반응형.
- 데스크톱·모바일 로컬 미리보기 승인 → **배포 완료**(push `a9dfdfb`, 라이브 검증: 캐주얼 섹션·아이콘 2종 200·http→301 OK).

## 2. 다음 액션
- ✅ **배포 완료**(2026-06-25): 배지는 "Google Play 출시 예정"(Android 우선) 그대로 유지하기로 확정. 라이브 검증 OK.
- ⏳ 하루 스도쿠 **실제 런처 아이콘 생성**(별도, `sudoku-mb-2606` — 현재 Flutter 기본). 생성 시 홈의 SVG와 동일 Soft Pop 디자인 유지.

## 3. 연관 — 하루 스도쿠 프로젝트 (별도 리포)
- `~/apps/sudoku-mb-2606` (Flutter, `com.leoworks.sudoku`). 오늘 브랜드 **하루 스도쿠(Haru Sudoku)** 확정, 설계 스펙 + **Slice 1 핵심 루프** 진행(별도 세션). 상세는 그 리포의 `CLAUDE.md`·`docs/`.

## 4. 핵심 사실 (빠른 참조)
- repo `github.com/illee/leoworks` · Pages `main`/`(root)` · `leoworks.kr`(가비아)
- 이메일: support@leoworks.kr(공개) · dev@leoworks.kr(구글 연락처) — ImprovMX → leodev19lee@gmail.com
- 홈페이지 제품: Lessi(라이브) · 멍냥로그 · 오솔로그 + **캐주얼 게임: 낱말채집 · 하루 스도쿠**
- 내부 문서 비공개(`_config.yml exclude: docs/`).

> 작성: Claude Code · 2026-06-25. 다음 세션: §0 → §2(배포 게이트) 확인.
