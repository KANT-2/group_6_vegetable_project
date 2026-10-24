# 공개 콘텐츠 복구

회원·배송지·장바구니·주문·개인 쿠폰 없이 프로젝트의 공개 콘텐츠를 새 Supabase 프로젝트에 복구하는 안내입니다. 기존 공유 DB에 초기 SQL을 다시 실행하지 말고, 비어 있는 새 프로젝트에서 진행합니다.

## 포함한 자료

| 자료                | 위치                                                       | 내용                                                            |
| ------------------- | ---------------------------------------------------------- | --------------------------------------------------------------- |
| DB 구조·권한·함수   | `supabase/migrations/*.sql`                                | 공개 콘텐츠와 개인 기능의 스키마. 개인 데이터는 포함하지 않음   |
| 상품·채소           | `supabase/seeds/catalog.sql`                               | 채소 21종, 상품 71개(판매 중 67개·판매 종료 4개)                |
| 공식 레시피         | `supabase/seeds/verified-recipes.sql`                      | 레시피 16개, 상품 연결 99건                                     |
| 쿠폰 행사 정의      | `202610130001_coupon_wallet.sql`                           | 공개 행사 3개. 개인 발급 내역은 포함하지 않음                   |
| 앱 편집 콘텐츠      | `src/data/`, `data/food-catalog/`, `public/`               | 쉬운 레시피 84개, 농가 이야기·영양·행사·사진 연결과 정적 이미지 |
| Storage 원본 이미지 | [market-images.zip](../supabase/storage/market-images.zip) | `market-images` bucket의 JPG 93개                               |
| 이미지 검증 목록    | [manifest.json](../supabase/storage/manifest.json)         | ZIP과 각 파일의 SHA-256, 상대 경로·크기                         |

`supabase/seeds/recipes.sql`은 과거 예시 레시피입니다. 아래 복구 절차에서는 실행하지 않습니다. 화면의 레시피 목록은 앱의 편집 JSON과 DB 레시피를 합치고 대체된 레시피를 제외하므로, DB의 16개와 화면의 84개를 더한 개수로 판단하지 않습니다.

## 1. 새 Supabase에 구조와 공개 데이터 적용

1. 비어 있는 새 Supabase 프로젝트를 준비합니다. Supabase의 기본 `auth`·`storage` 스키마가 있는 환경을 기준으로 합니다.
2. SQL Editor에서 `supabase/migrations/`의 SQL 파일을 **파일명 오름차순**으로 각각 실행합니다. 현재는 `202610080001_profiles.sql`부터 `202610130001_coupon_wallet.sql`까지 13개입니다. SQL Editor 실행은 CLI migration 이력에 자동 등록되지 않습니다.
3. `supabase/seeds/catalog.sql`을 실행합니다.
4. `supabase/seeds/verified-recipes.sql`을 실행합니다.

적용 후 다음 읽기 전용 SQL로 개수를 확인합니다.

```sql
select 'vegetables' as dataset, count(*) as count from public.vegetables
union all select 'products_total', count(*) from public.products
union all select 'products_active', count(*) from public.products where is_active
union all select 'recipes', count(*) from public.recipes
union all select 'recipe_products', count(*) from public.recipe_products
union all select 'coupon_campaigns', count(*) from public.coupon_campaigns;
```

기대값은 순서대로 **21 / 71 / 67 / 16 / 99 / 3**입니다. 행사 기간이 지난 쿠폰의 발급 제한은 원래 구현대로 유지합니다.

## 2. Storage 이미지 복구

1. `supabase/storage/market-images.zip`을 내려받아 압축을 풉니다.
2. 새 프로젝트의 Storage에서 `market-images` bucket을 확인합니다. Storage migration이 공개 bucket과 정책을 구성합니다.
3. 압축의 `market-images/` 아래 파일을 bucket의 같은 상대 경로로 업로드합니다. 예를 들어 `market-images/products/apple.jpg`는 bucket 안의 `products/apple.jpg`여야 합니다. bucket 안에 `market-images` 폴더를 한 번 더 만들지 않습니다.
4. 대시보드에서 하위 폴더별 파일을 선택해 업로드하고, 총 93개인지 확인합니다. 파일 이름과 내용은 변경하지 않습니다.
5. `manifest.json`의 파일별 SHA-256과 크기로 업로드할 원본 파일을 대조할 수 있습니다. ZIP 자체는 PowerShell의 `Get-FileHash -Algorithm SHA256`으로 확인합니다.

저장소의 `public/images`에는 후속 교체 사진도 포함되어 있습니다. 백업 Storage 93개 중 36개는 저장소 정적 파일과 바이트가 달랐고, 채소 대표 사진 7종도 달랐습니다. **백업 당시 Storage 사진을 재현하려면 이 ZIP을 사용합니다.** 상품 갤러리·농가 사진·배너 등 앱의 정적 사진은 저장소의 기존 경로를 그대로 사용합니다.

## 3. 앱 연결

`.env.example`을 참고해 로컬 `.env.local` 또는 배포 환경에 새 프로젝트의 `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`, `NEXT_PUBLIC_SITE_URL`을 설정합니다. DB 모드를 확인할 때는 `USE_MOCK_DATA=true`를 사용하지 않습니다.

`npm ci` 후 앱을 실행해 상품 목록·채소 정보·레시피·농가 이야기·행사와 이미지 로딩을 확인합니다. Google OAuth와 회원 기능을 사용하려면 새 Supabase 프로젝트의 Google provider·callback도 별도로 설정해야 합니다. 공개 콘텐츠 복구에는 기존 회원 계정이나 토큰이 필요하지 않습니다.

## 대조·검증 기록

2026년 10월 24일, 사용자가 제공한 `db_cluster-16-10-2026@06-28-25.backup.gz`의 공개 테이블 5개를 저장소의 migration·seed와 대조했습니다. PGlite의 임시 PostgreSQL에 전체 migration과 위 두 seed를 적용한 결과, `products`·`vegetables`·`recipes`·`recipe_products`·`coupon_campaigns`의 모든 행·공개 값이 일치했습니다. `created_at`·`updated_at`은 비교에서 제외했습니다. 새 Supabase 클라우드에 실제 복구한 검증은 아닙니다.

추가한 ZIP은 제공된 Storage 백업에서 JPG 93개만 선별하고 최상위 프로젝트 ID 폴더를 제거한 것입니다. 이미지 바이트와 bucket 안의 경로를 보존했습니다. 파일 구성과 JPEG 메타데이터 검사에서 회원 파일·EXIF·XMP·IPTC·주석은 발견되지 않았습니다. 이 검사는 사진의 사용 허락을 새로 확인한 결과가 아니며 기존 출처·사용 조건 기록을 따릅니다.

원본 DB 덤프에는 회원 이메일·식별정보, 배송지·주문, 세션·인증 토큰이 포함되어 있어 **저장소에 추가하지 않았습니다.** 구조와 공개 콘텐츠는 위 자료로 복구하며 개인 데이터는 비어 있는 상태로 시작합니다.
