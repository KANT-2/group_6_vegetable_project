// 채소 "그 자체"의 정보 (예: 당근이라는 채소의 특징, 보관법)
// 가격이 붙은 판매 상품은 product.ts에 따로 있어요.
// DB 테이블: vegetables (ERD 2-1)

// 채소 분류: 이 6개 값만 쓸 수 있어요.
export type VegetableCategory =
  | "root" // 뿌리채소 (당근, 양파 등)
  | "leaf" // 잎채소 (양배추 등)
  | "fruit_veg" // 열매채소 (파프리카 등)
  | "mushroom" // 버섯
  | "fruit" // 과일
  | "seasoning"; // 양념채소 (마늘, 대파 등)

// 화면에 보여줄 한글 이름
export const VEGETABLE_CATEGORY_LABELS: Record<VegetableCategory, string> = {
  root: "뿌리채소",
  leaf: "잎채소",
  fruit_veg: "열매채소",
  mushroom: "버섯",
  fruit: "과일",
  seasoning: "양념채소",
};

// 채소 이름표 양식
export interface Vegetable {
  id: string; // 번호표. 예: "carrot" (겹치면 안 돼요)
  name: string; // 이름. 예: "당근"
  category: VegetableCategory; // 분류
  description: string; // 채소 소개
  storageGuide?: string; // 보관법 (없어도 됨)
  prepGuide?: string; // 손질법 (없어도 됨)
  season?: string; // 제철. 예: "9~12월" (없어도 됨)
  imageUrl?: string; // 사진 주소 (없어도 됨)
}
