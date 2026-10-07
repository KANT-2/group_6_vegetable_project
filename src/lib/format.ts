// 가격과 할인율을 화면에 보여주는 함수 (B 담당)

// 2900 → "2,900원"
export function formatPrice(price: number): string {
  return `${price.toLocaleString("ko-KR")}원`;
}

// 판매가 2900, 정상가 4800 → 40 (%)
// 할인율은 DB에 저장하지 않고 항상 가격으로 계산해요.
export function getDiscountRate(price: number, originalPrice: number): number {
  if (originalPrice <= 0 || price >= originalPrice) return 0;
  return Math.round((1 - price / originalPrice) * 100);
}
