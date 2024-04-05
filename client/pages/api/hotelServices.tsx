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

export const getHotelRooms = async (hotelId: number) => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}hotel-rooms/${hotelId}`
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
