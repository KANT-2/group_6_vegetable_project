import assert from "node:assert/strict";
import test from "node:test";
import { getImageUrl } from "../src/lib/storage.ts";

test("Storage URL은 허용한 bucket 상대 경로로만 만든다", (t) => {
  const previous = { ...process.env };
  t.after(() => {
    process.env = previous;
  });
  process.env.NEXT_PUBLIC_SUPABASE_URL = "https://example.supabase.co";
  process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY = "test-public-key";
  assert.equal(getImageUrl(null), null);
  assert.equal(
    getImageUrl("products/감자 사진.jpg"),
    "https://example.supabase.co/storage/v1/object/public/market-images/products/%EA%B0%90%EC%9E%90%20%EC%82%AC%EC%A7%84.jpg",
  );
  for (const path of [
    "https://evil.example/image.jpg",
    "/products/a.jpg",
    "products/../a.jpg",
    "products//a.jpg",
    "products/a\\b.jpg",
    "private/a.jpg",
  ]) {
    assert.throws(() => getImageUrl(path));
  }
});
