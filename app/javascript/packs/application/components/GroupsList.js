import React from "react";
import ImageCard from "./ImageCard";

const GroupsList = ({ groups }) => (
  <div>
    {groups.map(group => (
      <ImageCard
        key={group.id}
        imageURL={group.image_url}
        url={group.slug}
        title={group.name}
      />
    ))}
  </div>
);

export default GroupsList;
