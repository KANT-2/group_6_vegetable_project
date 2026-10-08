import { requireSupabaseConfig } from "./supabase/config.ts";

export function getImageUrl(path: string | null | undefined): string | null {
  if (!path) return null;
  const parts = path.split("/");
  if (
    !["brand", "products", "vegetables", "recipes"].includes(parts[0]) ||
    parts.length < 2 ||
    parts.some(
      (part) =>
        !part ||
        part === "." ||
        part === ".." ||
        /[\\\u0000-\u001f]/.test(part),
    )
  ) {
    throw new Error(
      "이미지는 market-images bucket의 상대 경로로 지정해주세요.",
    );
  }
  const { url } = requireSupabaseConfig();
  return `${url.replace(/\/$/, "")}/storage/v1/object/public/market-images/${parts.map(encodeURIComponent).join("/")}`;
}
