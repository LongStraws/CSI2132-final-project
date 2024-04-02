import { Inter } from "next/font/google";
import { getAllHotels } from "./api/hotelServices";
import { useEffect, useState } from "react";
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
  TableFooter,
} from "@/components/ui/table";

const inter = Inter({ subsets: ["latin"] });
interface Hotel {
  hotelid: number;
  name: string;
  chainid: number;
  rating: number;
  numberofrooms: number;
  address: string;
  email: string;
  contactphone: string;
}
export default function Home() {
  const [allHotels, setAllHotels] = useState<Hotel[]>([]);

  const fetchAllHotels = async () => {
    const hotels = await getAllHotels();
    setAllHotels(hotels!);
  };

  useEffect(() => {
    fetchAllHotels();
  }, []);

  return (
    <Table>
      <TableCaption>A list of your recent invoices.</TableCaption>
      <TableHeader>
        <TableRow>
          <TableHead className='w-[100px]'>ChainId</TableHead>
          <TableHead>Name</TableHead>
          <TableHead>Rating</TableHead>
          <TableHead className='text-right'>Address</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {allHotels.map((allHotels) => (
          <TableRow key={allHotels.name}>
            <TableCell className='font-medium'>{allHotels.chainid}</TableCell>
            <TableCell>{allHotels.name}</TableCell>
            <TableCell>{allHotels.rating}</TableCell>
            <TableCell className='text-right'>{allHotels.address}</TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  );
}
