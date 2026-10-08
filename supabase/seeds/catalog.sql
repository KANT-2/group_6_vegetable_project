begin;
-- =========================================================
-- B · 상품·채소 초기 데이터 (seed)
-- 원본: B가 제공한 catalog_seed.sql (feat/useob의 src/data/mock 기준)
-- main의 기존 Mock 6개와 다릅니다. B의 데이터 PR 병합 후 일치합니다.
-- 채소 12개, 상품 16개
-- 농가 이름·가격·보관법 문구는 시연용 가상 데이터입니다.
-- 여러 번 실행해도 중복되지 않도록 id 기준으로 덮어써요(upsert).
-- 순서: 채소 먼저 → 상품 (상품이 채소를 가리키기 때문)
-- =========================================================

insert into public.vegetables (id, name, category, description, storage_guide, prep_guide, season, image_path) values
  ('carrot', '당근', 'root', '달큰하고 아삭한 뿌리채소예요. 생으로 먹어도, 볶거나 쪄도 맛있어요.', '흙을 털지 말고 신문지에 싸서 냉장고 채소칸에 세워 보관하세요.', '껍질 가까이에 영양이 많아서 깨끗이 씻은 뒤 얇게만 벗기세요.', '9~12월', 'vegetables/carrot.jpg'),
  ('apple', '사과', 'fruit', '새콤달콤한 과일이에요. 그대로 먹거나 샐러드, 잼으로 즐겨요.', '하나씩 비닐에 싸서 냉장 보관하세요. 다른 과일과 떨어뜨려 두면 좋아요.', '흐르는 물에 문질러 씻고, 흠집 난 부분만 도려내면 돼요.', '9~11월', 'vegetables/apple.jpg'),
  ('shiitake', '표고버섯', 'mushroom', '향이 진하고 쫄깃한 버섯이에요. 국물 요리와 볶음에 잘 어울려요.', '물에 씻지 말고 키친타월에 싸서 냉장 보관하세요.', '밑동을 떼고 젖은 행주로 겉을 살살 닦아 주세요.', '3~5월, 9~11월', 'vegetables/shiitake.jpg'),
  ('cabbage', '양배추', 'leaf', '아삭하고 단맛이 나는 잎채소예요. 샐러드, 볶음, 쌈으로 먹어요.', '심을 도려내고 젖은 키친타월을 채운 뒤 랩으로 싸서 냉장 보관하세요.', '겉잎 한두 장을 떼고 한 장씩 흐르는 물에 씻어 주세요.', '3~6월', 'vegetables/cabbage.jpg'),
  ('paprika', '파프리카', 'fruit_veg', '색이 화사하고 단맛이 나는 열매채소예요. 생으로도 볶아서도 좋아요.', '물기를 닦고 비닐에 담아 냉장 보관하세요.', '꼭지와 씨를 빼고 흐르는 물에 씻어 주세요.', '4~10월', 'vegetables/paprika.jpg'),
  ('onion', '양파', 'root', '볶으면 단맛이 살아나는 채소예요. 거의 모든 요리의 기본 재료예요.', '망에 담아 바람이 잘 통하고 그늘진 곳에 걸어 두세요.', '위아래를 자르고 겉껍질을 벗긴 뒤, 차갑게 해서 썰면 눈이 덜 매워요.', '4~6월', 'vegetables/onion.jpg'),
  ('potato', '감자', 'root', '포슬포슬하고 담백한 뿌리채소예요. 찌거나 굽거나 볶아서 다양하게 즐겨요.', '빛이 들지 않는 서늘한 곳에 두세요. 사과를 한두 개 함께 두면 싹이 덜 나요.', '싹이나 초록색으로 변한 부분은 독성이 있으니 넉넉히 도려내고 조리하세요.', '6~9월', 'vegetables/potato-small.jpg'),
  ('sweet-potato', '고구마', 'root', '구우면 꿀처럼 달콤해지는 뿌리채소예요. 간식으로도 식사로도 좋아요.', '냉장 보관하면 쉽게 상해요. 신문지에 싸서 13~15도 정도 서늘한 실온에 두세요.', '흙을 씻어 내고 껍질째 굽거나 쪄 드세요. 자른 면은 물에 담가 두면 덜 변해요.', '9~11월', 'vegetables/sweet-potato.jpg'),
  ('tomato', '토마토', 'fruit_veg', '새콤하고 감칠맛이 나는 열매채소예요. 익혀 먹으면 영양 흡수가 더 좋아요.', '덜 익었으면 실온에서 후숙하고, 잘 익으면 꼭지를 아래로 해서 냉장 보관하세요.', '꼭지를 떼고 씻어요. 껍질을 벗기려면 열십자로 칼집을 내 끓는 물에 살짝 데치세요.', '5~8월', 'vegetables/tomato.jpg'),
  ('cucumber', '오이', 'fruit_veg', '아삭하고 시원한 열매채소예요. 무침, 냉국, 피클로 즐겨요.', '물기를 닦고 키친타월에 싸서 꼭지가 위로 가게 세워 냉장 보관하세요.', '굵은 소금으로 겉을 문질러 씻으면 가시가 정리되고 색이 선명해져요.', '4~8월', 'vegetables/cucumber.jpg'),
  ('green-onion', '대파', 'seasoning', '국, 볶음, 무침 어디에나 들어가는 기본 양념채소예요.', '흰 부분과 초록 부분을 나눠 썰어 밀폐 용기에 담아 냉장·냉동 보관하세요.', '뿌리를 자르고 겉껍질 한 겹을 벗긴 뒤 흐르는 물에 씻어 주세요.', '11~2월', 'vegetables/green-onion.jpg'),
  ('spinach', '시금치', 'leaf', '단맛이 도는 잎채소예요. 나물, 국, 볶음으로 두루 써요.', '젖은 키친타월에 싸서 뿌리가 아래로 가게 세워 냉장 보관하세요.', '뿌리 쪽 흙을 깨끗이 씻고, 끓는 소금물에 30초 정도만 데치세요.', '11~3월', 'vegetables/spinach.jpg')
on conflict (id) do update set
  name = excluded.name,
  category = excluded.category,
  description = excluded.description,
  storage_guide = excluded.storage_guide,
  prep_guide = excluded.prep_guide,
  season = excluded.season,
  image_path = excluded.image_path;

insert into public.products (id, vegetable_id, name, description, price, original_price, unit, ugly_reason, condition_note, farm_name, farm_region, farm_story, image_path, is_seasonal, is_featured, is_active) values
  ('carrot-bent-1kg', 'carrot', '못난이 당근 1kg', '달고 아삭한 해남 당근이에요. 크기가 고르지 않고 조금 휘어서 일반 유통에서 제외됐어요.', 2900, 4800, '1kg (5~8개)', 'bent', '모양이 조금 휘었을 뿐, 당도와 식감은 정상품과 같아요.', '해남 김씨농장', '전라남도 해남', '황토밭에서 당근을 키우고 있어요. 모양이 달라도 정성은 똑같습니다.', 'products/carrot.jpg', true, true, true),
  ('apple-scratched-2kg', 'apple', '흠과 사과 2kg', '바람에 흔들려 생긴 흠집 때문에 B급이 된 사과예요. 새콤달콤한 맛은 그대로예요.', 12900, 19800, '2kg (7~9개)', 'scratched', '껍질에 작은 흠집이 있지만 과육은 멀쩡해요.', '청송 사과농원', '경상북도 청송', '일교차가 큰 산골에서 사과를 키워 단맛이 진해요.', 'products/apple.jpg', true, true, true),
  ('shiitake-irregular-500g', 'shiitake', 'B급 표고버섯 500g', '크기가 고르지 않아 선별에서 빠진 표고버섯이에요. 국물 요리와 볶음에 좋아요.', 6900, 9900, '500g', 'irregular', '갓 크기가 제각각이지만 향과 식감은 좋아요.', '장흥 버섯농가', '전라남도 장흥', '참나무 원목에서 버섯을 천천히 키우고 있어요.', 'products/shiitake.jpg', false, true, true),
  ('cabbage-small-1ea', 'cabbage', '꼬마 양배추 1통', '크기가 작아 규격에서 빠진 양배추예요. 1인 가구가 한 번에 쓰기 딱 좋아요.', 1900, 3500, '1통', 'small', '일반 양배추보다 작지만 속이 꽉 찼어요.', '평창 고랭지농장', '강원도 평창', '서늘한 고랭지에서 자라 아삭함이 살아 있어요.', 'products/cabbage.jpg', false, true, true),
  ('paprika-irregular-4ea', 'paprika', '못난이 파프리카 4입', '모양이 고르지 않은 파프리카 4가지 색 모음이에요. 샐러드와 볶음에 좋아요.', 4900, 7900, '4입', 'irregular', '모양이 삐뚤지만 색과 단맛은 그대로예요.', '영양 파프리카농장', '경상북도 영양', '빨강, 노랑, 주황, 초록 파프리카를 함께 키워요.', 'products/paprika.jpg', false, false, true),
  ('onion-small-2kg', 'onion', '꼬마 양파 2kg', '알이 작아 규격 외로 분류된 양파예요. 볶음, 카레, 장아찌에 쓰기 좋아요.', 3900, 6700, '2kg', 'small', '알이 작아 손질이 조금 번거롭지만 맛은 똑같아요.', '무안 양파밭', '전라남도 무안', '바닷바람이 부는 황토밭에서 양파를 키워요.', 'products/onion.jpg', true, false, true),
  ('potato-small-3kg', 'potato', '꼬마 감자 3kg', '크기가 작아 선별에서 빠진 감자예요. 조림, 버터구이, 통감자구이에 딱이에요.', 5900, 9800, '3kg', 'small', '알이 작아 껍질째 통으로 조리하기 좋아요.', '강릉 감자밭', '강원도 강릉', '서늘한 고랭지 바람을 맞고 자라 포슬포슬해요.', 'products/potato-small.jpg', true, false, true),
  ('potato-scratched-2kg', 'potato', '흠집 감자 2kg', '수확할 때 생긴 흠집 때문에 B급이 된 감자예요. 껍질만 벗기면 정상품과 같아요.', 4500, 6900, '2kg', 'scratched', '캐는 과정에서 생긴 겉 흠집이 있지만 속은 멀쩡해요.', '평창 고랭지농장', '강원도 평창', '양배추와 함께 감자도 기르고 있어요.', 'products/potato-scratched.jpg', true, false, true),
  ('sweet-potato-bent-2kg', 'sweet-potato', '못난이 꿀고구마 2kg', '모양이 고르지 않아 상자에 예쁘게 담기 어려운 꿀고구마예요. 맛은 그대로예요.', 7900, 12900, '2kg', 'bent', '모양이 휘고 길쭉하지만 구우면 꿀처럼 달아요.', '해남 황토고구마', '전라남도 해남', '황토밭에서 키워 당도가 높은 꿀고구마예요.', 'products/sweet-potato.jpg', true, false, true),
  ('sweet-potato-small-1-5kg', 'sweet-potato', '한입 고구마 1.5kg', '작아서 규격에서 빠진 고구마예요. 간식으로 하나씩 꺼내 먹기 편해요.', 5500, 8500, '1.5kg', 'small', '한입 크기로 작아서 에어프라이어에 굽기 좋아요.', '여주 고구마농원', '경기도 여주', '모래가 섞인 땅에서 키워 껍질이 매끈해요.', 'products/sweet-potato-small.jpg', true, false, true),
  ('tomato-irregular-1kg', 'tomato', '못난이 토마토 1kg', '모양이 고르지 않은 토마토예요. 소스, 수프, 샐러드에 쓰기 좋아요.', 4900, 7900, '1kg', 'irregular', '크기와 모양이 제각각이지만 완숙으로 수확했어요.', '부여 토마토하우스', '충청남도 부여', '줄기에서 충분히 익혀 따서 감칠맛이 진해요.', 'products/tomato.jpg', true, false, true),
  ('cucumber-bent-5ea', 'cucumber', '휜 오이 5입', '곧게 자라지 않아 B급이 된 오이예요. 무침이나 오이냉국으로 드셔 보세요.', 2900, 4500, '5입', 'bent', '활처럼 휘었지만 아삭함은 그대로예요.', '천안 오이농장', '충청남도 천안', '매일 아침 수확해서 바로 보내 드려요.', 'products/cucumber.jpg', true, false, true),
  ('green-onion-small-1bunch', 'green-onion', '짧은 대파 1단', '길이가 짧은 대파예요. 썰어서 냉동해 두면 국과 볶음에 바로 쓸 수 있어요.', 1900, 3200, '1단', 'small', '길이가 짧아 규격에서 빠졌지만 향은 진해요.', '진도 대파밭', '전라남도 진도', '겨울 바닷바람을 맞고 자라 단맛이 나요.', 'products/green-onion.jpg', false, false, true),
  ('spinach-small-500g', 'spinach', '잎 작은 시금치 500g', '잎 크기가 작아 선별에서 빠진 시금치예요. 나물이나 된장국에 좋아요.', 2500, 3900, '500g', 'small', '잎이 작지만 연하고 단맛이 좋아요.', '남해 섬시금치', '경상남도 남해', '바닷바람을 맞고 자라 뿌리 쪽이 달아요.', 'products/spinach.jpg', false, false, true),
  ('carrot-irregular-3kg', 'carrot', '굵기 제각각 당근 3kg', '굵기가 고르지 않은 당근을 넉넉히 담았어요. 당근주스나 라페를 만들기 좋아요.', 6900, 11500, '3kg', 'irregular', '굵기가 들쭉날쭉하지만 주스나 요리에는 문제없어요.', '제주 구좌당근', '제주특별자치도 구좌', '화산토에서 키워 단단하고 달아요.', 'products/carrot-bulk.jpg', true, false, true),
  ('apple-small-3kg', 'apple', '소과 사과 3kg', '크기가 작아 선물용에서 빠진 사과예요. 도시락 과일로 하나씩 챙기기 좋아요.', 15900, 25800, '3kg (14~18개)', 'small', '크기가 작아 한 번에 먹기 좋은 사이즈예요.', '영주 사과마을', '경상북도 영주', '소백산 아래 일교차가 큰 곳에서 키웠어요.', 'products/apple-small.jpg', true, false, true)
on conflict (id) do update set
  vegetable_id = excluded.vegetable_id,
  name = excluded.name,
  description = excluded.description,
  price = excluded.price,
  original_price = excluded.original_price,
  unit = excluded.unit,
  ugly_reason = excluded.ugly_reason,
  condition_note = excluded.condition_note,
  farm_name = excluded.farm_name,
  farm_region = excluded.farm_region,
  farm_story = excluded.farm_story,
  image_path = excluded.image_path,
  is_seasonal = excluded.is_seasonal,
  is_featured = excluded.is_featured,
  is_active = excluded.is_active;

commit;
