import Image from "next/image";
import { Inter } from "next/font/google";
import { HotelsTable } from "@/components/hotelsTable";

const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  return (
    <HotelsTable/>
  );
}
