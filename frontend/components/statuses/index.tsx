import { useQuery } from "@apollo/client";
import React from "react";
import { graphql } from "../../graphql";

const getStatusQuery = graphql(`
  query getStatus($id: ID!) {
    status(id: $id) {
      id
    }
  }
`);

const Status = ({ id }) => {
  const { data, loading } = useQuery(getStatusQuery, { variables: { id } });

  if (loading) {
  }

  if (data) {
    return <div>{data.status?.id}</div>;
  }
};

export default Status;
