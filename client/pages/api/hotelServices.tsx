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

export const getAllHotels = async (location?: string) => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}hotels${
        location ? `?location=${location}` : ""
      }`
    );
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
    console.log(error)
  }
}
