import type { CatalogFilters } from "@/schemas/product";
import type { ProductSort } from "@/types/product";

// 정렬 버튼에 보여 줄 이름
export const SORT_LABELS: Record<ProductSort, string> = {
  newest: "기본순",
  price_asc: "낮은 가격순",
  price_desc: "높은 가격순",
  discount_desc: "할인율순",
};

// 필터 버튼을 눌렀을 때 갈 주소: 지금 조건에서 하나만 바꿔요.
export function catalogHref(
  current: CatalogFilters,
  change: Partial<CatalogFilters>,
) {
  const next = { ...current, ...change };
  const query = new URLSearchParams();
  if (next.category) query.set("category", next.category);
  if (next.reason) query.set("reason", next.reason);
  if (next.sort && next.sort !== "newest") query.set("sort", next.sort);
  const text = query.toString();
  return text ? `/products?${text}` : "/products";
}
