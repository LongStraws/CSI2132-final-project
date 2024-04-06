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
import Link from "next/link";

const inter = Inter({ subsets: ["latin"] });

export interface Hotel {
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
  const [chainId, setChainID] = useState<number>();
  const [rating, setRating] = useState<number>();

  const fetchAllHotels = async () => {
    const hotels = await getAllHotels();
    setAllHotels(hotels!);
  };
  const fetchHotelLocation = async (
    location: string,
    chainId?: number,
    rating?: number
  ) => {
    const hotels = await getAllHotels(location, chainId, rating);
    console.log(location, chainId, rating);
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
          className='location-input'
          onChange={(e) => setLocation(e.target.value)}
          placeholder='Enter Location'
        ></Input>
        <Input
          className='chainID-input'
          onKeyPress={(e) => !/[0-9]/.test(e.key) && e.preventDefault()}
          onChange={(e) => setChainID(parseInt(e.target.value))}
          placeholder='Enter Chain ID'
        ></Input>
        <Input
          className='Rating-input'
          onKeyPress={(e) => !/[0-9]/.test(e.key) && e.preventDefault()}
          onChange={(e) => setRating(parseInt(e.target.value))}
          placeholder='Enter Rating'
        ></Input>
        <Button onClick={() => fetchHotelLocation(location, chainId, rating)}>
          {" "}
          Submit Query
        </Button>
      </div>
      <Table>
        <TableCaption>A list of your hotels.</TableCaption>
        <TableHeader>
          <TableRow>
            <TableHead className='w-[100px]'>Hotelid</TableHead>
            <TableHead>Name</TableHead>
            <TableHead>ChainID</TableHead>
            <TableHead className='text-right'>Rating</TableHead>
            <TableHead className='text-right'>NumberOfRooms</TableHead>
            <TableHead className='text-right'>Address</TableHead>
            <TableHead className='text-right'>Email</TableHead>
            <TableHead className='text-right'>Phone</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {allHotels?.map((Hotel) => (
            <TableRow key={Hotel.hotelid}>
              <TableCell className='font-medium'>
                <Link href={`/hotel/${Hotel.hotelid}`}>
                  <Button>{Hotel.hotelid}</Button>{" "}
                </Link>
              </TableCell>
              <TableCell className='font-medium'>
                <Link href={`/view1`}>
                  <Button>{Hotel.name}</Button>{" "}
                </Link>
              </TableCell>{" "}
              <TableCell className='font-medium'>{Hotel.chainid}</TableCell>
              <TableCell>{Hotel.rating}</TableCell>
              <TableCell>{Hotel.numberofrooms}</TableCell>
              <TableCell className='font-medium'>
                <Link href={`/view2`}>
                  <Button>{Hotel.address}</Button>{" "}
                </Link>
              </TableCell>{" "}
              <TableCell className='text-right'>{Hotel.email}</TableCell>
              <TableCell className='text-right'>{Hotel.contactphone}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </>
  );
}
