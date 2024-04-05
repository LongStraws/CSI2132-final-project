import { useRouter } from 'next/router'
import React, { useEffect, useState } from 'react'
import { Hotel } from '..'
import { getHotel, getHotelRooms } from '../api/hotelServices'
import { Table, TableBody, TableCaption, TableHead, TableHeader, TableRow, TableCell } from '@/components/ui/table'

export interface Room {
    roomid: number;
    hotelid: number;
    price: string;
    amenities: string;
    capacity: string;
    view: string;
    extendable: boolean;
    problems: null | string[];
  }

const HotelPage = () => {
    const router = useRouter()

    const [hotelRooms, setHotelRooms] = useState<Room[]>([])
    const [hotel, setHotel] = useState<Hotel[]>([])

    const fetchHotelRooms = async (numericId: number) => {
        const rooms = await getHotelRooms(numericId);
        setHotelRooms(rooms);
    };
    
    const fetchHotel = async (numericId: number) => {
        const hotel = await getHotel(numericId);
        setHotel(hotel);
    };

    useEffect(() => {
        const fetchHotelData = async () => {
          if (router.isReady) {
            const numericId = typeof router.query.id === 'string' ? parseInt(router.query.id, 10) : NaN;
      
            if (!isNaN(numericId)) {
              await fetchHotelRooms(numericId);
              await fetchHotel(numericId);
            } else {
              console.error('Hotel ID is invalid');
              // Optionally, redirect or show an error message
            }
          }
        };
      
        fetchHotelData();
      }, [router.isReady, router.query.id]);
  return (
    <>
    <h1>{hotel[0]?.name}</h1>
    <Table>
        <TableCaption>A list of available rooms for hotel {hotel[0]?.name}</TableCaption>
        <TableHeader>
            <TableRow>
                <TableHead className='w-96'>Amenities</TableHead>
                <TableHead>Price</TableHead>
                <TableHead>Capacity</TableHead>
                <TableHead>View</TableHead>
                <TableHead>Extendable</TableHead>
                <TableHead className='text-right'></TableHead>
            </TableRow>
        </TableHeader>
        <TableBody>
            {hotelRooms.map((room) => (
                <TableRow key={room.hotelid}>
                    <TableCell className='font-medium'>{room.amenities}</TableCell>
                    <TableCell>${room.price}</TableCell>
                    <TableCell>{room.capacity}</TableCell>
                    <TableCell>{room.view}</TableCell>
                    <TableCell>{(room.extendable).toString()}</TableCell>
                </TableRow>
            ))}
        </TableBody>
    </Table>
    </>
  )
}

export default HotelPage