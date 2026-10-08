import "server-only";
import { getSupabaseConfig } from "@/lib/supabase/config";

// .env.local에 Supabase 값이 없으면 Mock Data로 화면을 보여 줘요.
// (키가 없는 팀원도 화면 작업을 할 수 있게)
export function isMockCatalog() {
  return getSupabaseConfig() === null;
}

// DB의 image_path("products/carrot.jpg")를 화면용 주소로 바꿔요.
// Storage(market-images)에 사진을 올리기 전까지는 public/images의 같은 파일을 써요.
// 업로드가 끝나면 이 함수만 getImageUrl()로 바꾸면 돼요.
export function toImageSrc(path: string | null): string | undefined {
  if (!path) return undefined;
  const fileName = path.split("/").pop();
  return fileName ? `/images/${fileName}` : undefined;
}
