"use client";
import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  SelectValue,
  SelectTrigger,
  SelectContent,
  SelectItem,
  Select,
} from "@/components/ui/select";

import { z } from "zod";
import { useRouter } from "next/router";
import {
  createBooking,
  getAllCustomers,
  getEmployees,
} from "../api/hotelServices";

const formSchema = z.object({
  customerFullName: z.string().min(1, "Customer name is required"),
  employeeid: z.string().min(1, "Employee name is required"),
});

export interface Booking {
  bookingid: number;
  roomid: number;
  Customerid: number;
  Employeeid: number;
  startdate: Date;
  enddate: Date;
}
export interface Customer {
  customerid: number;
  fullname: string;
  address: string;
  idtype: "Passport" | "Driver License";
  idnumber: string;
  registrationdate: Date;
}

export interface Employee {
  employeeid: number;
  hotelid: number;
  fullname: string;
  address: string;
  ssn_sin: string;
  role_position: string;
}

const BookingPage = () => {
  const router = useRouter();

  const [roomId, setRoomId] = useState<number>(0);
  const [startDate, setStartDate] = useState<string>("");
  const [endDate, setEndDate] = useState<string>("");
  const [employees, setEmployees] = useState<Employee[]>([]);
  const [customers, setCustomers] = useState<Customer[]>([]);
  const [toggleCustomerForm, setToggleCustomerForm] = useState<Boolean>(false);
  const [toggleEmployeeForm, setToggleEmployeeForm] = useState<Boolean>(false);

  const fetchEmployees = async () => {
    const allEmployees = await getEmployees();
    setEmployees(allEmployees);
  };
  const fetchCustomers = async () => {
    const allCustomers = await getAllCustomers();
    setCustomers(allCustomers);
  };
  const fetchCustomer = async (customerId: number) => {};
  const createCustomer = async (
    fullName: string,
    address: string,
    idType: string,
    idNumber: string
  ) => {};

  useEffect(() => {
    const fetchData = () => {
      if (router.isReady) {
        const numericId =
          typeof router.query.id === "string"
            ? parseInt(router.query.id, 10)
            : NaN;
        const sDate =
          typeof router.query.start_date === "string"
            ? router.query.start_date
            : null;
        const eDate =
          typeof router.query.end_date === "string"
            ? router.query.end_date
            : null;

        if (!isNaN(numericId) && sDate && eDate) {
          setRoomId(numericId);
          setStartDate(sDate);
          setEndDate(eDate);
          fetchCustomers();
          fetchEmployees();
        } else {
          console.error("Hotel ID or date range is invalid");
          // Optionally, redirect or show an error message
        }
      }
    };

    fetchData();
  }, [
    router.isReady,
    router.query.id,
    router.query.start_date,
    router.query.end_date,
  ]);

  const bookForm = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      customerFullName: "", // Empty string as default, expecting a string input
      employeeid: "", // Similar to roomId, expecting a number input. Adjust initial value as necessary
    },
  });

  const customerToggle = bookForm.watch("customerFullName");
  const employeeToggle = bookForm.watch("employeeid");

  const handleSubmit = (values: z.infer<typeof formSchema>) => {
    // roomId is already a variable
    const customerFullName = values.customerFullName;
    const employeeId = values.employeeid;
    // startDate, and endDate are already defined variables
    console.log({ roomId, customerFullName, employeeId, startDate, endDate });
    createBooking(
      roomId,
      customerFullName,
      parseInt(employeeId, 10),
      startDate,
      endDate
    );
  };

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <Form {...bookForm}>
        <form
          onSubmit={bookForm.handleSubmit(handleSubmit)}
          className="max-w-md w-full flex flex-col gap-4"
        >
          <h1 className="text-2xl text-center">Booking Form</h1>
          <Input
            placeholder="Email address"
            type="email"
            disabled={true}
            value={roomId}
          />
          <FormField
            control={bookForm.control}
            name="customerFullName"
            render={({ field }) => {
              return (
                <FormItem>
                  <FormLabel>Customer</FormLabel>
                  <Select onValueChange={field.onChange}>
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="Select a customer" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      {customers?.map((customer) => (
                        <SelectItem value={customer.fullname.toString()}>
                          {customer.fullname}
                        </SelectItem>
                      ))}
                      <SelectItem value="None">
                        <Button onClick={() => setToggleCustomerForm(true)}>
                          New Customer
                        </Button>
                      </SelectItem>
                    </SelectContent>
                  </Select>
                  <FormMessage />
                </FormItem>
              );
            }}
          />
          {/* {customerToggle && (
            <>
            <h1 className="text-2xl">New Customer</h1>

            </>
          )} */}
          <FormField
            control={bookForm.control}
            name="employeeid"
            render={({ field }) => {
              return (
                <FormItem>
                  <FormLabel>Employee</FormLabel>
                  <Select onValueChange={field.onChange}>
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="Select an employee" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      {employees?.map((employee) => (
                        <SelectItem value={employee.employeeid.toString()}>
                          {employee.fullname}
                        </SelectItem>
                      ))}
                      <SelectItem value="None">
                        <Button onClick={() => setToggleEmployeeForm(true)}>
                          New Employee
                        </Button>
                      </SelectItem>
                    </SelectContent>
                  </Select>
                  <FormMessage />
                </FormItem>
              );
            }}
          />
          {/* {accountType or employeeToggle === "company" && (
            <FormField
              control={bookForm.control}
              name="companyName"
              render={({ field }) => {
                return (
                  <FormItem>
                    <FormLabel>Company name</FormLabel>
                    <FormControl>
                      <Input placeholder="Company name" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                );
              }}
            />
          )} */}
          <Input
            placeholder="Start Date"
            type="date"
            disabled={true}
            value={startDate}
          />
          <Input
            placeholder="Start Date"
            type="date"
            disabled={true}
            value={endDate}
          />
          <Button type="submit" className="w-full">
            Submit
          </Button>
        </form>
      </Form>
    </main>
  );
};

export default BookingPage;
