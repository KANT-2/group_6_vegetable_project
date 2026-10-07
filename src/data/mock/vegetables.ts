// 연습용 채소 정보 6개 (Mock Data)
// 진짜 DB가 준비되기 전에 화면을 만들 때 써요.
// 나중에는 DB의 vegetables 표에서 같은 모양으로 가져와요.

import type { Vegetable } from "../../types/vegetable";

export const vegetables: Vegetable[] = [
  {
    id: "carrot",
    name: "당근",
    category: "root",
    description: "달큰하고 아삭한 뿌리채소예요. 생으로 먹어도, 볶거나 쪄도 맛있어요.",
    storageGuide: "흙을 털지 말고 신문지에 싸서 냉장고 채소칸에 세워 보관하세요.",
    prepGuide: "껍질 가까이에 영양이 많아서 깨끗이 씻은 뒤 얇게만 벗기세요.",
    season: "9~12월",
    imageUrl: "/images/carrot.jpg",
  },
  {
    id: "apple",
    name: "사과",
    category: "fruit",
    description: "새콤달콤한 과일이에요. 그대로 먹거나 샐러드, 잼으로 즐겨요.",
    storageGuide: "하나씩 비닐에 싸서 냉장 보관하세요. 다른 과일과 떨어뜨려 두면 좋아요.",
    prepGuide: "흐르는 물에 문질러 씻고, 흠집 난 부분만 도려내면 돼요.",
    season: "9~11월",
    imageUrl: "/images/apple.jpg",
  },
  {
    id: "shiitake",
    name: "표고버섯",
    category: "mushroom",
    description: "향이 진하고 쫄깃한 버섯이에요. 국물 요리와 볶음에 잘 어울려요.",
    storageGuide: "물에 씻지 말고 키친타월에 싸서 냉장 보관하세요.",
    prepGuide: "밑동을 떼고 젖은 행주로 겉을 살살 닦아 주세요.",
    season: "3~5월, 9~11월",
    imageUrl: "/images/shiitake.jpg",
  },
  {
    id: "cabbage",
    name: "양배추",
    category: "leaf",
    description: "아삭하고 단맛이 나는 잎채소예요. 샐러드, 볶음, 쌈으로 먹어요.",
    storageGuide: "심을 도려내고 젖은 키친타월을 채운 뒤 랩으로 싸서 냉장 보관하세요.",
    prepGuide: "겉잎 한두 장을 떼고 한 장씩 흐르는 물에 씻어 주세요.",
    season: "3~6월",
    imageUrl: "/images/cabbage.jpg",
  },
  {
    id: "paprika",
    name: "파프리카",
    category: "fruit_veg",
    description: "색이 화사하고 단맛이 나는 열매채소예요. 생으로도 볶아서도 좋아요.",
    storageGuide: "물기를 닦고 비닐에 담아 냉장 보관하세요.",
    prepGuide: "꼭지와 씨를 빼고 흐르는 물에 씻어 주세요.",
    season: "4~10월",
    imageUrl: "/images/paprika.jpg",
  },
  {
    id: "onion",
    name: "양파",
    category: "root",
    description: "볶으면 단맛이 살아나는 채소예요. 거의 모든 요리의 기본 재료예요.",
    storageGuide: "망에 담아 바람이 잘 통하고 그늘진 곳에 걸어 두세요.",
    prepGuide: "위아래를 자르고 겉껍질을 벗긴 뒤, 차갑게 해서 썰면 눈이 덜 매워요.",
    season: "4~6월",
    imageUrl: "/images/onion.jpg",
  },
];
