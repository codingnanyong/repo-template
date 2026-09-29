# Claude + Codex 공용 작업 구조와 접두사 규칙

이 문서는 저장소 루트에 분리된 AI 작업 폴더의 목적과 사용 방법을
설명한다. 공용 기능은 특정 도구 폴더에 넣지 않는다. Claude와 Codex는
각각 `CLAUDE.md`와 `AGENTS.md`를 진입점으로 사용한 뒤 동일한 루트
폴더를 직접 읽는다.

## 기본 원칙

- `AGENTS.md`는 Claude와 Codex가 함께 따르는 최상위 작업 계약이다.
- `CLAUDE.md`는 Claude 전용 진입점이지만 공용 규칙은 복제하지 않는다.
- `skills/`, `agents/`, `commands/`, `rules/` 등의 루트 폴더가 공용 원본이다.
- `.claude/`에는 Claude Code 실행에 필요한 설정만 둔다.
- 문서는 Claude, 이미지는 Codex가 품질을 주도한다.
- 코드, 테스트, 설정, 자동화, 리뷰는 두 도구가 모두 수행할 수 있다.
- 진행 중인 작업만 `templates/shared-handoff.md`에 기록한다. 장기적으로 유지할
  결정은 `docs/`나 코드에 반영한다.

## 소유 범위 접두사

지원 폴더의 파일이나 하위 디렉터리는 이름만 보고 사용 범위를 알 수
있도록 다음 접두사를 사용한다.

- `shared-<name>`: Claude와 Codex가 함께 사용한다. 별도 이유가 없으면
  이 접두사가 기본값이다.
- `claude-<name>`: Claude만 사용하는 절차나 역할이다.
- `codex-<name>`: Codex만 사용하는 절차나 역할이다.

일반 파일은 `rules/shared-payroll-review.md`처럼 파일명에 접두사를 붙인다.
스킬과 플러그인은 `skills/shared-release/SKILL.md`처럼 하위 폴더에
접두사를 붙인다. `README.md`, `SKILL.md`, `AGENTS.md`, `CLAUDE.md`, 표준
커뮤니티 파일, dotfile, 필수 매니페스트 이름은 예외다.

## 폴더별 목적

| 경로 | 목적 | 주 사용자 | 수정하는 경우 |
| --- | --- | --- | --- |
| `skills/` | 작업을 완료하는 재사용 절차 | Claude, Codex | 새로운 작업 유형이나 표준 절차가 필요할 때 |
| `agents/` | 역할과 책임, 검토 관점 정의 | Claude, Codex | 담당 역할이나 품질 책임을 추가·변경할 때 |
| `commands/` | 사용자가 시작하는 공용 작업 흐름 | Claude, Codex | 반복적으로 실행할 조정 절차가 필요할 때 |
| `rules/` | 결과물이 지켜야 하는 제약과 품질 기준 | Claude, Codex | 파일 유형이나 작업 영역의 불변 규칙이 바뀔 때 |
| `hooks/` | 명령 실행 전후의 자동 안전장치 | 도구 런타임 | 반복 검사를 자동화하거나 위험 동작을 차단할 때 |
| `plugins/` | 프로젝트가 사용하는 플러그인 목록과 설정 근거 | 사람, Claude, Codex | 플러그인을 도입·교체·제거할 때 |
| `output-styles/` | 응답과 인수인계의 표현 방식 | Claude, Codex | 보고 형식이나 커뮤니케이션 규칙이 바뀔 때 |
| `statusline/` | 모델, 브랜치, 컨텍스트 같은 세션 상태 표시 | 도구 런타임 | 표시 항목이나 실행 환경이 바뀔 때 |
| `templates/` | 인수인계 등 재사용 가능한 공용 양식 | 현재 작업자와 다음 작업자 | 다른 도구나 세션이 작업을 이어받아야 할 때 |
| `assets/images/` | 이미지 입력, 작업본, 최종본 관리 | 주로 Codex | 이미지가 생성·편집·승인될 때 |
| `docs/` | 사람이 읽는 장기 문서 | 주로 Claude | 정책, 설계, 사용법을 지속적으로 보존할 때 |
| `.claude/` | Claude Code 런타임 설정 | Claude Code | 훅 연결이나 로컬 실행 설정이 바뀔 때 |
| `.github/` | GitHub Actions, PR 템플릿, 자동화 스크립트 | 공동 | CI, PR 정책, 알림 자동화가 바뀔 때 |

## 비슷해 보이는 폴더의 차이

### `skills/`: 어떻게 수행하는가

스킬은 특정 작업을 완료하기 위한 절차다.

- `skills/claude-documentation/`: 문서 작성과 검증 절차. Claude가 주도한다.
- `skills/codex-image-assets/`: 이미지 생성·편집·통합 절차. Codex가 주도한다.
- `skills/shared-implementation/`: 코드, 테스트, 설정, 자동화 구현 절차.
  Claude와 Codex가 모두 사용한다.

### `agents/`: 어떤 역할로 판단하는가

에이전트 문서는 작업자의 책임과 검토 관점을 정의한다.

- `claude-documentation-writer.md`: 정확하고 중복 없는 문서를 책임진다.
- `codex-image-creator.md`: 이미지 품질, 원본 보존, 접근성을 책임진다.
- `shared-implementation.md`: 구현 범위, 테스트, 기존 변경 보존을 책임진다.
- `shared-code-reviewer.md`: 오류, 회귀, 보안, 문서 불일치를 검토한다.

### `rules/`: 무엇을 반드시 지켜야 하는가

규칙은 작업 방식보다 결과물의 제약에 집중한다. 예를 들어 이미지
스킬은 생성 순서를 설명하고, 이미지 규칙은 원본을 덮어쓰지 말아야
한다는 불변 조건을 정의한다.

### `commands/`: 언제 공용 흐름을 시작하는가

명령 문서는 반복되는 조정 흐름의 진입점이다. 현재
`commands/shared-handoff.md`는 Claude와 Codex 사이에 작업을 넘길 때 기록해야
할 항목을 정의한다.

## 실제 작업 흐름

### 문서 작업

1. Claude가 `skills/claude-documentation/SKILL.md`를 읽는다.
2. `agents/claude-documentation-writer.md`의 책임과
   `rules/shared-documentation.md`의
   제약을 적용한다.
3. 구현을 확인한 뒤 `README.md` 또는 `docs/`의 기존 정본을 수정한다.
4. 이미지가 필요하면 요구사항을 `templates/shared-handoff.md`에 기록하고
   Codex에 넘긴다.

### 이미지 작업

1. Codex가 `skills/codex-image-assets/SKILL.md`를 읽는다.
2. `agents/codex-image-creator.md`와 `rules/shared-image-assets.md`를 적용한다.
3. 참고 이미지는 `assets/images/source/`, 작업본은 `generated/`, 승인된
   결과물은 `final/`에 저장한다.
4. 문구나 문서 수정이 필요하면 `templates/shared-handoff.md`를 통해 Claude에
   넘긴다.

### 공동 구현

1. 현재 작업자가 `skills/shared-implementation/SKILL.md`와
   `templates/shared-handoff.md`를 확인한다.
2. `agents/shared-implementation.md`와 `rules/shared-implementation.md`를 적용한다.
3. 코드와 테스트를 구현하고 관련 문서·이미지 소비 코드도 함께
   검증한다.
4. 다른 도구가 이어서 작업해야 할 때만 `commands/shared-handoff.md`에 따라
   인수인계를 갱신한다.

## 인수인계 파일 사용법

`templates/shared-handoff.md`에는 다음 작업자가 바로 실행할 수 있는 정보만
남긴다.

- 목표와 현재 상태
- 현재 담당자와 다음 담당자
- 확정된 결정과 제약
- 정확한 파일 경로
- 이미 수행한 검사
- 다음 작업과 남은 검토

대화 전체, 장기 설계 문서, 완료된 작업 기록은 넣지 않는다. 인수인계가
소비되면 상태를 `idle`로 되돌린다.

## 새 기능을 추가할 때

1. 절차가 필요하면 `skills/<접두사>-<기능>/SKILL.md`를 추가한다.
2. 별도 책임이나 판단 관점이 필요하면
   `agents/<접두사>-<역할>.md`를 추가한다.
3. 반드시 지켜야 할 조건은 `rules/<접두사>-<영역>.md`에 둔다.
4. 반복 실행 진입점이 필요하면
   `commands/<접두사>-<명령>.md`를 추가한다.
5. `AGENTS.md`의 라우팅과 이 문서의 폴더 표를 갱신한다.
6. 같은 내용을 `.claude/`나 다른 도구 전용 폴더에 복제하지 않는다.

## 관련 문서

- 공통 작업 계약: [`AGENTS.md`](../../AGENTS.md)
- Claude 진입점: [`CLAUDE.md`](../../CLAUDE.md)
- Git/PR 절차: [`shared-git-workflow.md`](shared-git-workflow.md)
- 현재 인수인계: [`templates/shared-handoff.md`](../../templates/shared-handoff.md)
- 새 프로젝트 초기화:
  [`shared-project-bootstrap.md`](../../templates/shared-project-bootstrap.md)
