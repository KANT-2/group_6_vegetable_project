begin;

-- 기존 비공개 bucket을 실수로 공개로 전환하지 않습니다.
do $$
begin
  if exists (select 1 from storage.buckets where id = 'market-images' and not public) then
    raise exception 'market-images already exists as a private bucket';
  end if;
end;
$$;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('market-images', 'market-images', true, 5242880,
  array['image/jpeg', 'image/png', 'image/webp', 'image/avif'])
on conflict (id) do nothing;

-- public bucket의 이미지 URL은 공개 읽기입니다. 일반 앱 사용자의 쓰기는 막습니다.
-- 다른 bucket의 기존 정책을 바꾸지 않고 이 bucket에만 제한을 적용합니다.
create policy market_images_no_client_insert on storage.objects
  as restrictive for insert to anon, authenticated
  with check (bucket_id <> 'market-images');
create policy market_images_no_client_update on storage.objects
  as restrictive for update to anon, authenticated
  using (bucket_id <> 'market-images') with check (bucket_id <> 'market-images');
create policy market_images_no_client_delete on storage.objects
  as restrictive for delete to anon, authenticated
  using (bucket_id <> 'market-images');

commit;
