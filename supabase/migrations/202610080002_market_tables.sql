-- C 이상재: ERD v4 공통 테이블 구성. 202610080001_profiles.sql 다음에 적용합니다.
-- 주문 생성 트랜잭션과 모의 결제 RPC는 이후 기능 구현에서 추가합니다.
begin;

create table public.vegetables (
  id text primary key check (id ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  name text not null check (length(btrim(name)) > 0 and char_length(name) between 1 and 50),
  category text not null check (category in ('root', 'leaf', 'fruit_veg', 'mushroom', 'fruit', 'seasoning')),
  description text not null,
  storage_guide text,
  prep_guide text,
  season text,
  image_path text,
  created_at timestamptz not null default now()
);

create table public.products (
  id text primary key check (id ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  vegetable_id text not null references public.vegetables(id) on delete restrict,
  name text not null check (length(btrim(name)) > 0 and char_length(name) between 1 and 100),
  price integer not null check (price > 0),
  original_price integer not null check (original_price >= price),
  unit text not null check (length(btrim(unit)) > 0),
  ugly_reason text not null check (ugly_reason in ('small', 'bent', 'scratched', 'irregular')),
  description text not null,
  condition_note text,
  farm_name text not null check (length(btrim(farm_name)) > 0),
  farm_region text,
  farm_story text,
  image_path text,
  is_seasonal boolean not null default false,
  is_featured boolean not null default false,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index products_vegetable_id_idx on public.products (vegetable_id);
create index products_is_active_idx on public.products (is_active);

create table public.recipes (
  id text primary key check (id ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  name text not null check (length(btrim(name)) > 0),
  description text not null,
  cook_time_min integer not null check (cook_time_min > 0),
  difficulty text not null check (difficulty in ('easy', 'normal', 'hard')),
  servings integer check (servings > 0),
  ingredients jsonb not null default '[]'::jsonb check (jsonb_typeof(ingredients) = 'array'),
  steps jsonb not null default '[]'::jsonb check (jsonb_typeof(steps) = 'array'),
  image_path text,
  created_at timestamptz not null default now()
);

create table public.recipe_products (
  recipe_id text not null references public.recipes(id) on delete cascade,
  product_id text not null references public.products(id) on delete cascade,
  primary key (recipe_id, product_id)
);
create index recipe_products_product_id_idx on public.recipe_products (product_id);

create table public.cart_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id text not null references public.products(id) on delete cascade,
  quantity integer not null default 1 check (quantity between 1 and 99),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, product_id)
);

create table public.wishlist_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id text not null references public.products(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, product_id)
);
-- 위 UNIQUE 인덱스가 user_id로 시작하므로 본인 목록 조회에도 사용됩니다.

create table public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  request_key uuid not null,
  status text not null default 'pending' check (status in ('pending', 'paid', 'payment_failed', 'cancelled')),
  total_amount bigint not null check (total_amount > 0),
  recipient_name text not null check (length(btrim(recipient_name)) > 0),
  recipient_phone text not null check (length(btrim(recipient_phone)) > 0),
  postal_code text not null check (postal_code ~ '^[0-9]{5}$'),
  address text not null check (length(btrim(address)) > 0),
  address_detail text,
  paid_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, request_key),
  check ((status = 'paid' and paid_at is not null) or (status <> 'paid' and paid_at is null))
);
create index orders_user_created_at_idx on public.orders (user_id, created_at desc);

create table public.order_items (
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id text not null references public.products(id) on delete restrict,
  product_name text not null check (length(btrim(product_name)) > 0),
  product_unit text not null check (length(btrim(product_unit)) > 0),
  unit_price integer not null check (unit_price > 0),
  quantity integer not null check (quantity between 1 and 99),
  primary key (order_id, product_id)
);
create index order_items_product_id_idx on public.order_items (product_id);

create function public.set_market_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
create trigger products_updated_at before update on public.products
  for each row execute function public.set_market_updated_at();
create trigger cart_items_updated_at before update on public.cart_items
  for each row execute function public.set_market_updated_at();
create trigger orders_updated_at before update on public.orders
  for each row execute function public.set_market_updated_at();

alter table public.vegetables enable row level security;
alter table public.products enable row level security;
alter table public.recipes enable row level security;
alter table public.recipe_products enable row level security;
alter table public.cart_items enable row level security;
alter table public.wishlist_items enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;

-- Supabase 기본 GRANT와 무관하게 일반 사용자의 권한을 명시합니다.
revoke all on table public.vegetables, public.products, public.recipes,
  public.recipe_products, public.cart_items, public.wishlist_items,
  public.orders, public.order_items from public, anon, authenticated;
revoke all on table public.profiles from public;
grant all on table public.vegetables, public.products, public.recipes,
  public.recipe_products, public.profiles, public.cart_items,
  public.wishlist_items, public.orders, public.order_items to service_role;

grant select on table public.vegetables, public.products, public.recipes,
  public.recipe_products to anon, authenticated;
create policy vegetables_public_read on public.vegetables
  for select to anon, authenticated using (true);
create policy products_active_read on public.products
  for select to anon, authenticated using (is_active);
create policy recipes_public_read on public.recipes
  for select to anon, authenticated using (true);
create policy recipe_products_public_read on public.recipe_products
  for select to anon, authenticated using (true);

grant select, delete on table public.cart_items to authenticated;
grant insert (user_id, product_id, quantity), update (user_id, product_id, quantity)
  on table public.cart_items to authenticated;
create policy cart_select_own on public.cart_items
  for select to authenticated using ((select auth.uid()) = user_id);
create policy cart_insert_own on public.cart_items
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy cart_update_own on public.cart_items
  for update to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy cart_delete_own on public.cart_items
  for delete to authenticated using ((select auth.uid()) = user_id);

grant select, delete on table public.wishlist_items to authenticated;
grant insert (user_id, product_id) on table public.wishlist_items to authenticated;
create policy wishlist_select_own on public.wishlist_items
  for select to authenticated using ((select auth.uid()) = user_id);
create policy wishlist_insert_own on public.wishlist_items
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy wishlist_delete_own on public.wishlist_items
  for delete to authenticated using ((select auth.uid()) = user_id);

-- 주문 총액·단가·상태는 클라이언트가 직접 쓰지 못합니다.
grant select on table public.orders, public.order_items to authenticated;
create policy orders_select_own on public.orders
  for select to authenticated using ((select auth.uid()) = user_id);
create policy order_items_select_own on public.order_items
  for select to authenticated using (
    exists (select 1 from public.orders
      where orders.id = order_items.order_id and orders.user_id = (select auth.uid()))
  );

commit;
