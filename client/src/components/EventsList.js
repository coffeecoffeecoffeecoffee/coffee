import React from "react";
import ImageCard from "./ImageCard";

const EventsList = ({ events }) => (
  <div>
    {events.map(event => (
      <ImageCard
        key={event.id}
        imageURL={event.image_url}
        url={event.venue_url}
        title={event.name}
        time={event.start_at}
      />
    ))}
  </div>
);

export default EventsList;
