import axios from "axios";

export const getAllHotels = async (location?: string) => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}hotels${
        location ? `?location=${location}` : ""
      }`
    );
    return response.data;
  } catch (error) {
    // Handle error
    console.error(error);
  }
};

export const getHotelRooms = async (hotelId: number) => {
  try {
    const response = await axios.get(
      `${process.env.NEXT_PUBLIC_HOST}/hotel-rooms/${hotelId}`
    );
    return response.data;
  } catch (error) {
    // Handle error
    console.error(error);
  }
};
