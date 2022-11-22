import "../styles/globals.css";
import type { AppProps } from "next/app";
import React from "react";
import { ApolloProvider } from "@apollo/client";
import client from "../graphql/client";

export default function App({ Component, pageProps }: AppProps) {
  return (
    <ApolloProvider client={client}>
      <Component {...pageProps} />
    </ApolloProvider>
  );
}
