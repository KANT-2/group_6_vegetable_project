"use server";

import { revalidatePath } from "next/cache";
import { requireUser } from "@/lib/auth";
import { createClient } from "@/lib/supabase/server";
import { profileSchema } from "@/schemas/profile";
import type { ActionResult } from "@/types/action";

export async function updateProfile(input: unknown): Promise<ActionResult> {
  const parsed = profileSchema.safeParse(input);
  if (!parsed.success)
    return { ok: false, error: parsed.error.issues[0].message };
  const user = await requireUser();

  try {
    const supabase = await createClient();
    const { error } = await supabase.from("profiles").upsert({
      id: user.id,
      nickname: parsed.data.nickname,
    });
    if (error) return { ok: false, error: "프로필을 저장하지 못했습니다." };
  } catch {
    return { ok: false, error: "프로필 서버에 연결할 수 없습니다." };
  }

  revalidatePath("/", "layout");
  return { ok: true };
}
