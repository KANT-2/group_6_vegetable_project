// 로그인 후 이동은 앱 내부 경로만 허용합니다.
export function safeNextPath(value: string | undefined): string {
  if (!value || !value.startsWith("/")) return "/mypage";
  try {
    const decoded = decodeURIComponent(value);
    if (decoded.startsWith("//") || /[\\\u0000-\u0020\u007f]/.test(decoded)) {
      return "/mypage";
    }
    const url = new URL(value, "https://internal.invalid");
    return url.origin === "https://internal.invalid"
      ? `${url.pathname}${url.search}${url.hash}`
      : "/mypage";
  } catch {
    return "/mypage";
  }
}
