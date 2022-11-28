import { useQuery } from "@apollo/client";
import React from "react";
import { graphql } from "../../graphql";

const accountQuery = graphql(`
  query account {
    account(id: "https://ruby.social/ryanbigg") {
      uri
    }
  }
`);

const AccountProfile = () => {
  const { data, loading, error } = useQuery(accountQuery);

  if (data) {
    return <div>{data.account.uri}</div>;
  }

  return null;
};

export default AccountProfile;
