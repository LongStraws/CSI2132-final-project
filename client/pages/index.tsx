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
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import ReqForm from "@/components/ReqForm";

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
  const [location, setLocation] = useState<string>("");

  const fetchAllHotels = async () => {
    const hotels = await getAllHotels();
    setAllHotels(hotels!);
  };
  const fetchHotelLocation = async (location: string) => {
    console.log(location, "location");
    const hotels = await getAllHotels(location);
    setAllHotels(hotels!);
  };

  useEffect(() => {
    console.log("fetching hotels");
    fetchAllHotels();
  }, []);

  return (
    <>
      <div
        className='text-right
      '
      >
        <Input
          className='test'
          onChange={(e) => setLocation(e.target.value)}
        ></Input>
        <Button onClick={() => fetchHotelLocation(location)}>
          {" "}
          Submit Location
        </Button>
      </div>
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
    </>
  );
}
