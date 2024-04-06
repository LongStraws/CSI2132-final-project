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
export interface View1 {
  area: string;
  availablerooms: string;
}
const View1Page = () => {
  const [allHotels, setAllHotels] = useState<View1[]>([]);

  const fetchAllHotels = async () => {
    const hotels = await getView("1");
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
            <TableHead className='w-[100px]'>Area</TableHead>
            <TableHead className='text-right'>Availalbe Rooms</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {allHotels?.map((Hotel) => (
            <TableRow key={Hotel.area}>
              <TableCell className='text-right font-medium inline-block text-nowrap'>
                {Hotel.area}
              </TableCell>
              <TableCell className='text-right'>
                {Hotel.availablerooms}
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </>
  );
};

export default View1Page;
