import assert from "node:assert/strict";
import test from "node:test";
import { safeNextPath } from "../src/lib/redirect.ts";
import { signInSchema } from "../src/schemas/auth.ts";
import { profileSchema } from "../src/schemas/profile.ts";

test("로그인 후 이동은 내부 경로만 허용한다", () => {
  assert.equal(safeNextPath("/cart?tab=wishlist"), "/cart?tab=wishlist");
  for (const path of [
    undefined,
    "https://evil.example",
    "//evil.example",
    "/\\evil.example",
    "/%2fevil.example",
    "/%5cevil.example",
    "/%0aevil",
    "/%",
    "javascript:alert(1)",
  ]) {
    assert.equal(safeNextPath(path), "/mypage");
  }
});

test("로그인 입력을 검증하고 비밀번호 공백은 보존한다", () => {
  const input = { email: " member@example.com ", password: " password " };
  assert.deepEqual(signInSchema.parse(input), {
    email: "member@example.com",
    password: " password ",
  });
  assert.equal(
    signInSchema.safeParse({ email: "invalid", password: "" }).success,
    false,
  );
  assert.equal(
    signInSchema.safeParse({ ...input, password: "a".repeat(1025) }).success,
    false,
  );
});

test("프로필은 닉네임만 변경하고 길이를 검증한다", () => {
  assert.deepEqual(profileSchema.parse({ nickname: " 새싹 " }), {
    nickname: "새싹",
  });
  for (const input of [
    { nickname: " " },
    { nickname: "가" },
    { nickname: "가".repeat(21) },
    { nickname: "새싹", id: "other-user" },
    { nickname: "새싹", role: "admin" },
  ]) {
    assert.equal(profileSchema.safeParse(input).success, false);
  }
});
