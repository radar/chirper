import { useQuery } from "@apollo/client";
import React from "react";
import { graphql } from "../../graphql";
import { TimelineQuery } from "../../graphql/graphql";
import Image from "next/image";

const timelineQuery = graphql(`
  query timeline {
    timeline {
      id
      content
      actor {
        uri
      }
    }
  }
`);

type TimelineProps = {
  statuses: TimelineQuery["timeline"];
};

type StatusProps = NonNullable<TimelineQuery["timeline"][0]>;

const Status = ({ actor, content }: StatusProps) => {
  return (
    <div className="border-b border-gray-600 py-2 px-4">
      <div className="flex items-center mb-2">
        <div className="w-[46px] h-[46px] bg-blue-400 mr-2 rounded-sm" />
        <bdi className="block">Display name</bdi>
        <div>{actor.uri}</div>
      </div>
      {content}
    </div>
  );
};

const Timeline = ({ statuses }: TimelineProps) => {
  return (
    <div className="dark:bg-gray-800">
      {statuses.map((status) => (
        <Status {...status} key={status.id} />
      ))}
    </div>
  );
};

const WrappedTimeline = () => {
  const { data, loading, error } = useQuery(timelineQuery);

  if (data) {
    return <Timeline statuses={data.timeline} />;
  }
};

export default WrappedTimeline;
