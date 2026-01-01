// lib/auth-client.ts
import { createAuthClient } from "better-auth/react";

export const { signIn, signOut, signUp, useSession } = createAuthClient({
  baseURL: process.env.NEXT_PUBLIC_APP_URL, // 배포된 도메인 또는 http://localhost:3000
});
