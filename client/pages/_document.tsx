import Footer from "@/components/Footer";
import Header from "@/components/Header";
import { Html, Head, Main, NextScript } from "next/document";

export default function Document() {
  return (
    <Html lang='en'>
      <Head />
      <body>
        <Header></Header>
        <Main />
        <NextScript />
        <Footer></Footer>
      </body>
    </Html>
  );
}
