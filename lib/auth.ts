// lib/auth.ts
import { betterAuth } from "better-auth";
import { prismaAdapter } from "better-auth/adapters/prisma";
import { prisma } from "./prisma"; // 이전에 만든 prisma 클라이언트

export const auth = betterAuth({
  database: prismaAdapter(prisma, {
    provider: "postgresql",
  }),
  emailAndPassword: {
    enabled: true, // 이메일/로그인 활성화
  },
  trustedOrigins: ["http://localhost:3000"],
});
