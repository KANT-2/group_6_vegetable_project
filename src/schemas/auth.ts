import { z } from "zod";

export const signInSchema = z.object({
  email: z.string().trim().email("올바른 이메일을 입력해주세요."),
  password: z.string().min(1, "비밀번호를 입력해주세요.").max(1024),
  next: z.string().max(2048).optional(),
});
