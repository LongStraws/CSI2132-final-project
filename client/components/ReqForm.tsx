"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { z } from "zod";
import Reac, { Dispatch, SetStateAction } from "react";
import { Button } from "@/components/ui/button";

import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
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

type ReqFormProps = {
  location: string;
  hotel: Hotel[] | null;
  setHotel: Dispatch<SetStateAction<File | null>>;
};

const formSchema = z.object({
  location: z.string(),
});

export function ReqForm() {
  // 1. Define your form.
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      location: "",
    },
  });

  // 2. Define a submit handler.
  function onSubmit(values: z.infer<typeof formSchema>) {
    // Do something with the form values.
    // ✅ This will be type-safe and validated.
    console.log(values);
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-8'>
        <FormField
          control={form.control}
          name='location'
          render={({ field }) => (
            <FormItem>
              <FormLabel>Location</FormLabel>
              <FormControl>
                <Input placeholder='input address' {...field} />
              </FormControl>
              <FormDescription>
                This is the address you're searching for
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type='submit'>Submit</Button>
      </form>
    </Form>
  );
}

export default ReqForm;
