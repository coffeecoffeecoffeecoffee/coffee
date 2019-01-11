import React from "react";

const GroupsList = ({ groups }) => (
  <div>
    {groups.map(group => (
      <div key={group.id}>
        <h1>{group.name}</h1>
      </div>
    ))}
  </div>
);

export default GroupsList;
