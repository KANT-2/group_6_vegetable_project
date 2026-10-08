import Link from "next/link";
import MockDataNotice from "@/components/products/MockDataNotice";
import ProductCard from "@/components/products/ProductCard";
import ProductFilters from "@/components/products/ProductFilters";
import { catalogFiltersSchema } from "@/schemas/product";
import { isMockCatalog } from "@/services/catalog-source";
import { countByReason, getProductList } from "@/services/products";

export const metadata = { title: "상품 목록 | 못난이마켓" };

// 주소: /products?category=root&reason=small&sort=price_asc
export default async function ProductsPage({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  // 1. 주소의 조건을 검사해서 허용된 값만 남겨요.
  const filters = catalogFiltersSchema.parse(await searchParams);
  // 2. 고른 분류의 상품을 가져와요. (DB 또는 Mock)
  const inCategory = await getProductList({ ...filters, reason: undefined });
  // 3. 못난이 이유 버튼마다 몇 개인지 세고, 고른 이유로 한 번 더 걸러요.
  const reasonCounts = countByReason(inCategory);
  const products = filters.reason
    ? inCategory.filter((p) => p.uglyReason === filters.reason)
    : inCategory;

  return (
    <main className="mx-auto w-full max-w-[1120px] px-4 py-6 sm:px-6">
      {/* 첫 화면에 상품이 보이도록 소개는 한 줄만 */}
      <h1 className="text-2xl font-bold text-stone-900">못난이 상품</h1>
      <p className="mt-1 text-sm text-stone-500">
        모양만 조금 다를 뿐, 맛은 그대로예요.
      </p>

      <div className="mt-4">
        <ProductFilters filters={filters} reasonCounts={reasonCounts} />
      </div>

      <p className="mb-3 mt-4 text-sm text-stone-500">
        상품 {products.length}개
      </p>

      {products.length > 0 ? (
        // 모바일 2열 → 데스크톱(lg) 4열
        <div className="grid grid-cols-2 gap-3 sm:gap-4 lg:grid-cols-4 lg:gap-6">
          {products.map((product, index) => (
            <ProductCard
              key={product.id}
              product={product}
              preload={index < 2}
            />
          ))}
        </div>
      ) : (
        <div className="rounded-[20px] bg-white p-10 text-center ring-1 ring-stone-200">
          <p className="font-bold text-stone-900">조건에 맞는 상품이 없어요.</p>
          <p className="mt-1 text-sm text-stone-500">
            다른 조건을 골라 보세요.
          </p>
          <Link
            href="/products"
            className="mt-4 inline-flex h-12 items-center rounded-xl bg-green-800 px-5 font-semibold text-white"
          >
            조건 초기화
          </Link>
        </div>
      )}

      <div className="mt-8">
        <MockDataNotice usingMock={isMockCatalog()} />
      </div>
    </main>
  );
}
