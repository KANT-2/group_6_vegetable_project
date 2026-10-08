# 실제 생성한 폴더 구조

로컬 관리 경로: `C:\dev\group_6_vegetable_project`

현재는 폴더 골격만 준비한 상태입니다. `package.json`, 실행 페이지, Next.js 설정, Supabase 연결은 아직 생성하지 않았으므로 `npm run dev`로 실행할 수 없습니다. README의 파일별 구조는 이후 구현 계획입니다.

빈 폴더는 Git이 저장하지 않으므로 각 끝 폴더에 `.gitkeep`을 넣었습니다. `.gitkeep`은 동작에 영향을 주지 않는 자리 표시 파일이며 해당 폴더에 실제 코드를 추가하면 제거할 수 있습니다.

```text
group_6_vegetable_project/
├─ src/
│  ├─ app/
│  │  ├─ story/
│  │  ├─ recipes/[id]/
│  │  ├─ products/[id]/
│  │  ├─ vegetables/[id]/
│  │  ├─ cart/
│  │  ├─ login/
│  │  ├─ mypage/
│  │  └─ api/
│  ├─ components/
│  │  ├─ common/
│  │  ├─ recipes/
│  │  ├─ products/
│  │  ├─ vegetables/
│  │  ├─ shopping/
│  │  └─ account/
│  ├─ services/
│  ├─ actions/
│  ├─ schemas/
│  ├─ lib/supabase/
│  ├─ context/
│  ├─ types/
│  └─ data/mock/
├─ public/images/
├─ supabase/
│  ├─ migrations/
│  └─ seeds/
├─ docs/
│  ├─ structure.md
│  ├─ wireframes/
│  └─ screenshots/
├─ tests/
├─ .vscode/
├─ .gitignore
└─ README.md
```

`[id]`는 폴더명 그대로 사용하며 상품·채소·레시피의 동적 상세 경로입니다. 메인 페이지는 이후 `src/app/page.tsx`, 목록은 `src/app/recipes/page.tsx`와 `src/app/products/page.tsx`에 추가합니다. `api/`는 필요한 HTTP 요청이 생길 때 Route Handler를 추가할 공간이며 별도 FastAPI 서버를 만들지 않습니다.

## 담당자와 사용 위치

| 담당 | 화면·컴포넌트 | 데이터·서버 작업 |
|---|---|---|
| A 조영우 | 메인·이야기·레시피 목록/상세, `components/recipes`, 디자인 규칙 | 레시피 `services`·`schemas`·`types`·Mock·migration·seed |
| B 심우섭 | 상품 목록/상세·채소 상세, `components/products`, `components/vegetables` | 상품·채소 `services`·`schemas`·`types`·Mock·migration·seed, 가격 표시 |
| C 이상재 | `components/common`, `components/account`, `components/shopping`, 로그인·마이페이지·장바구니/찜, 공통 layout·모바일 메뉴 | Supabase 연결·인증·개인 데이터 `services`·`actions`·`schemas`·`types`·권한·context |
| 세 사람 공동 | 문서·와이어프레임·실행 캡처 | 통합·모바일 교차 검수 |

공유 폴더라고 한 사람이 모든 파일을 맡는 것은 아닙니다. 예를 들어 `services/recipes.ts`는 A, `services/products.ts`는 B, `services/cart.ts`는 C입니다. README의 파일별 담당을 따릅니다.

## 이후 시작 순서

1. C가 공통 Next.js 패키지·설정·layout 기반을 구성합니다. 기존 폴더와 팀원이 추가한 파일을 보존하면서 초기화합니다.
2. A는 메인·이야기·레시피를 Mock 데이터로 연결하고 각 화면을 모바일까지 구현합니다. 레시피 목록·상세·DB는 A가 함께 담당합니다.
3. B는 자기 상품·채소 브랜치의 데이터를 공통 구조에 맞춰 PR로 연결합니다.
4. 각자 DB·인증 연동과 오류·빈 상태를 확인하고 전원이 모바일 교차 검수합니다.

기존 `feat/useob` 브랜치의 이미지·상품/채소 타입·Mock·가격 함수는 이번 골격 생성으로 병합하거나 변경하지 않았습니다.
