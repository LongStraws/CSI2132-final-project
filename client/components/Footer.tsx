import Image from "next/image";
import Link from "next/link";

const Footer = () => {
  return (
    <footer className='border-t'>
      {" "}
      <div className='flex-center wrapper flex-between flex flex-col gap-4 p-5 text-center sm:flex-row'>
        <p> Project by Yahya Osman, Sameed Jafri, Zakaria Abdisalam</p>
      </div>
    </footer>
  );
};

export default Footer;
