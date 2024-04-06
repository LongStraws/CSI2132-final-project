import Image from "next/image";
import Link from "next/link";

const Header = () => {
  return (
    <>
      {" "}
      <header className='border-t'>
        {" "}
        <div className='flex-center wrapper flex-between flex flex-col gap-4 p-5 text-center sm:flex-row'>
          <p> CSI2132 Final Project 2024</p>
        </div>
      </header>
    </>
  );
};

export default Header;
