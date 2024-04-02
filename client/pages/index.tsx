import Image from "next/image";
import { Inter } from "next/font/google";
import { HotelsTable } from "@/components/hotelsTable";
import { getAllHotels } from "./api/hotelServices";
import { useEffect, useState } from "react";

const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  const [allHotels, setAllHotels] = useState([]);

  const fetchAllHotels = async () => {
    const hotels = await getAllHotels()
    setAllHotels(hotels)
  }

  useEffect(() => {
    fetchAllHotels()
  },[]);

  return (
    <h1>{JSON.stringify(allHotels)}</h1>
  );
}
