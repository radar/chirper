import { Html, Head, Main, NextScript } from "next/document";

export default function Document() {
  return (
    <Html>
      <Head />
      <body className="dark:bg-gray-900 dark:text-white">
        <div className="flex">
          <div className="md:w-2/3 mx-auto mt-8">
            <Main />
          </div>
        </div>
        <NextScript />
      </body>
    </Html>
  );
}
