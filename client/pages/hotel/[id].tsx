import { useRouter } from "next/router";
import React, { useEffect, useState } from "react";
import { Hotel } from "..";
import { getHotel, getHotelRooms } from "../api/hotelServices";
import {
  Table,
  TableBody,
  TableCaption,
  TableHead,
  TableHeader,
  TableRow,
  TableCell,
} from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { zodResolver } from "@hookform/resolvers/zod";
import { format } from "date-fns";
import { CalendarIcon, AlertCircle } from "lucide-react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { cn } from "@/lib/utils";
import { Calendar } from "@/components/ui/calendar";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";

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

const FormSchema = z.object({
  startDate: z.date().optional(),
  endDate: z.date().optional(),
});

const HotelPage = () => {
  const router = useRouter();

  const [hotelRooms, setHotelRooms] = useState<Room[]>([]);
  const [hotel, setHotel] = useState<Hotel[]>([]);
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [endDate, setEndDate] = useState<Date | null>(null);

  const [dateValidationError, setDateValidationError] = useState("");
  const [availabilityChecked, setAvailabilityChecked] = useState(false);

  const form = useForm<z.infer<typeof FormSchema>>({
    resolver: zodResolver(FormSchema),
  });

  function onSubmit(data: z.infer<typeof FormSchema>) {
    const numericId =
      typeof router.query.id === "string" ? parseInt(router.query.id, 10) : NaN;
    if (!isNaN(numericId)) {
      const { startDate, endDate } = data;
      const start_date = startDate
        ? format(startDate, "yyyy-MM-dd")
        : undefined;
      const end_date = endDate ? format(endDate, "yyyy-MM-dd") : undefined;
      fetchHotelRooms(numericId, start_date, end_date);
      setAvailabilityChecked(true); // Indicate availability has been checked
      setDateValidationError(""); // Clear any existing error message
    } else {
      setAvailabilityChecked(false); // Ensure availability needs to be re-checked if submission failed
    }
  }

  // Handler for checking date selection and navigating
  const handleBookClick = (roomId: number) => {
    if (!availabilityChecked) {
      setDateValidationError(
        "Please check room availability for your selected dates before booking."
      );
      return;
    }
    if (startDate && endDate) {
      router.push(
        `/book/${roomId}?start_date=${format(
          startDate,
          "yyyy-MM-dd"
        )}&end_date=${format(endDate, "yyyy-MM-dd")}`
      );
    }
  };

  const DatePickerField = ({
    name,
    label,
    selectedDate,
    setSelectedDate,
    minDate,
    maxDate,
  }: {
    name: keyof z.infer<typeof FormSchema>;
    label: string;
    selectedDate: Date | null;
    setSelectedDate: React.Dispatch<React.SetStateAction<Date | null>>;
    minDate?: Date;
    maxDate?: Date;
  }) => (
    <FormField
      control={form.control}
      name={name}
      render={({ field }) => (
        <FormItem className='flex flex-col'>
          <FormLabel>{label}</FormLabel>
          <Popover>
            <PopoverTrigger asChild>
              <FormControl>
                <Button
                  variant={"outline"}
                  className={cn(
                    "w-[240px] pl-3 text-left font-normal",
                    !field.value && "text-muted-foreground"
                  )}
                >
                  {field.value ? (
                    format(field.value, "PPP")
                  ) : (
                    <span>Pick a date</span>
                  )}
                  <CalendarIcon className='ml-auto h-4 w-4 opacity-50' />
                </Button>
              </FormControl>
            </PopoverTrigger>
            <PopoverContent className='w-auto p-0' align='start'>
              <Calendar
                mode='single'
                selected={selectedDate ? selectedDate : undefined} // Use undefined instead of null
                onSelect={(date) => {
                  if (date) {
                    // Check if date is not undefined
                    field.onChange(date);
                    setSelectedDate(date);
                  }
                }}
                disabled={(date) => {
                  // Return true or false explicitly
                  return (
                    (minDate && date < minDate) ||
                    (maxDate && date > maxDate) ||
                    false
                  );
                }}
                initialFocus
              />
            </PopoverContent>
          </Popover>
          <FormMessage />
        </FormItem>
      )}
    />
  );

  const fetchHotelRooms = async (
    numericId: number,
    start_date?: string,
    end_date?: string
  ) => {
    const rooms = await getHotelRooms(numericId, start_date, end_date);
    setHotelRooms(rooms);
  };

  const fetchHotel = async (numericId: number) => {
    const hotel = await getHotel(numericId);
    setHotel(hotel);
  };

  useEffect(() => {
    const fetchHotelData = async () => {
      if (router.isReady) {
        const numericId =
          typeof router.query.id === "string"
            ? parseInt(router.query.id, 10)
            : NaN;

        if (!isNaN(numericId)) {
          await fetchHotelRooms(numericId);
          await fetchHotel(numericId);
        } else {
          console.error("Hotel ID is invalid");
          // Optionally, redirect or show an error message
        }
      }
    };

    fetchHotelData();
  }, [router.isReady, router.query.id]);
  return (
    <>
      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-5 px-5'>
          <div className='flex'>
            <DatePickerField
              name='startDate'
              label='Start Date'
              selectedDate={startDate}
              setSelectedDate={setStartDate}
              maxDate={endDate || undefined} // Disable any dates after the selected endDate
            />
            {/* End Date Picker */}
            <DatePickerField
              name='endDate'
              label='End Date'
              selectedDate={endDate}
              setSelectedDate={setEndDate}
              minDate={startDate || undefined} // Disable any dates before the selected startDate
            />
          </div>
          <Button type='submit' className='mx-auto'>
            Check Availability
          </Button>
        </form>
        {dateValidationError && (
          <Alert variant='destructive' className='m-2'>
            <AlertCircle className='h-4 w-4' />
            <AlertTitle>Error</AlertTitle>
            <AlertDescription>{dateValidationError}</AlertDescription>
          </Alert>
        )}
      </Form>

      <h1 className='text-4xl p-5 text-center'>{hotel[0]?.name}</h1>
      <Table>
        <TableCaption>
          A list of available rooms for hotel {hotel[0]?.name}
        </TableCaption>
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
            <TableRow key={room.roomid}>
              <TableCell className='font-medium'>{room.amenities}</TableCell>
              <TableCell>${room.price}</TableCell>
              <TableCell>{room.capacity}</TableCell>
              <TableCell>{room.view}</TableCell>
              <TableCell>{room.extendable.toString()}</TableCell>
              <TableCell>
                <Button onClick={() => handleBookClick(room.roomid)}>
                  Book
                </Button>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </>
  );
};

export default HotelPage;
