import "server-only";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getSupabaseConfig } from "@/lib/supabase/config";
import { safeNextPath } from "@/lib/redirect";

export async function getCurrentUser() {
  if (!getSupabaseConfig()) return null;
  const supabase = await createClient();
  const { data, error } = await supabase.auth.getUser();
  if (error && error.name !== "AuthSessionMissingError") {
    throw new Error(
      "로그인 상태를 확인할 수 없습니다. 잠시 후 다시 시도해주세요.",
    );
  }
  return data.user;
}

export async function requireUser(next = "/mypage") {
  const user = await getCurrentUser();
  if (!user) redirect(`/login?next=${encodeURIComponent(safeNextPath(next))}`);
  return user;
}
