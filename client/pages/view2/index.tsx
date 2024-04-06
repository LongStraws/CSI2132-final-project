import { Input } from "@/components/ui/input";
import { getView } from "../api/hotelServices";
import React, { useEffect, useState } from "react";
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
import Link from "next/link";
import { Button } from "@/components/ui/button";
export interface View2 {
  hotelname: string;
  totalcapacity: string;
}
const View2Page = () => {
  const [allHotels, setAllHotels] = useState<View2[]>([]);

  const fetchAllHotels = async () => {
    const hotels = await getView("2");
    console.log(hotels);
    setAllHotels(hotels!);
  };

  useEffect(() => {
    console.log("fetching hotels");
    fetchAllHotels();
  }, []);

  return (
    <>
      <Table className='table-layout:fixed'>
        <TableCaption>A list of your hotels.</TableCaption>
        <TableHeader>
          <TableRow>
            <TableHead className='w-[100px]'>Hotel Name</TableHead>
            <TableHead className='text-right'>Total Capacity</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {allHotels?.map((Hotel) => (
            <TableRow key={Hotel.hotelname}>
              <TableCell className='text-right font-medium inline-block text-nowrap'>
                {Hotel.hotelname}
              </TableCell>
              <TableCell className='text-right'>
                {Hotel.totalcapacity}
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </>
  );
};

export default View2Page;
