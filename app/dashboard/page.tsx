import { prisma } from "@/lib/prisma";

export default async function Test() {
  const users = await prisma.user.findMany();
  return <div>Test Page{JSON.stringify(users)}</div>;
}
