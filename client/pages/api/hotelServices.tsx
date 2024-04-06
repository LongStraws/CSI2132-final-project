import axios from "axios";

type Hotel = {
  hotelid: number;
  name: string;
  chainid: number;
  rating: number;
  numberofrooms: number;
  address: string;
  email: string;
  contactphone: string;
};

export const getAllHotels = async (
  location?: string,
  chainId?: number,
  rating?: number
) => {
  try {
    let queryString = "";
    if (location) {
      queryString += `?location=${location}`;
    }
    if (chainId) {
      queryString += `${queryString ? "&" : "?"}chain=${chainId}`;
    }
    if (rating) {
      queryString += `${queryString ? "&" : "?"}rating=${rating}`;
    }

    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}hotels${queryString}`
    );
    console.log(queryString);
    return response.data as Hotel[];
  } catch (error) {
    // Handle error
    console.error(error);
  }
};

export const getHotelRooms = async (
  hotelId: number,
  start_date?: string,
  end_date?: string
) => {
  try {
    let query = "";
    if (start_date) {
      query += `?start_date=${start_date}`;
    }
    if (end_date) {
      query += `${start_date ? "&" : "?"}end_date=${end_date}`;
    }
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}hotel-rooms/${hotelId}${query}`
    );
    return response.data;
  } catch (error) {
    // Handle error
    console.error(error);
  }
};

export const getHotel = async (hotelId: number) => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}hotel/${hotelId}`
    );
    return response.data;
  } catch (error) {
    console.log(error);
  }
};

export const getAllCustomers = async () => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}customers`
    );
    return response.data;
  } catch (error) {
    console.log(error);
  }
};

export const getCustomer = async (customerId: number) => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}customer/${customerId}`
    );
    return response.data;
  } catch (error) {
    console.log(error);
  }
};

export const getEmployees = async () => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}employees`
    );
    return response.data;
  } catch (error) {
    console.log(error);
  }
};

export const createCustomer = async (
  fullName: string,
  address: string,
  idType: string,
  idNumber: string
) => {
  try {
    const response = await axios.post(
      `${process.env.NEXT_PUBLIC_HOST}customer`,
      { fullName, address, idType, idNumber }
    );
    return response.data;
  } catch (error) {
    console.error("Error creating customer:", error);
    throw error;
  }
};

export const createBooking = async (
  roomId: number,
  customerFullName: string,
  employeeId: number,
  startDate: string,
  endDate: string
) => {
  try {
    const response = await axios.post(`${process.env.NEXT_PUBLIC_HOST}book`, {
      roomId,
      customerFullName,
      employeeId,
      startDate,
      endDate,
    });
    return response.data;
  } catch (error) {
    console.error("Error creating booking:", error);
    throw error;
  }
};

export const getView = async (viewNum: string) => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}view${viewNum}/`
    );
    return response.data;
  } catch (error) {
    console.log(error);
  }
};
