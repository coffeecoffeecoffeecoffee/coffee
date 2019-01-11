import React from "react";
import styled from "styled-components";
import { fonts } from "../constants";

const StyledCard = styled.div`
  background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
    url(${props => props.imageURL || ""});
  border-radius: 10px;
  color: #fff;
  height: 500px;
  margin: 40px auto;
  max-width: 500px;
  padding: 20px;
  text-align: center;
`;

const StyledCardBody = styled.div`
  position: relative;
  top: 50%;
  transform: perspective(1px) translateY(-50%);
`;

const StyledTitle = styled.a`
  color: inherit;
  font-family: ${fonts.default};
  font-size: 48px;
  font-weight: 500;
  text-decoration: none;
  word-wrap: break-word;
`;

const GroupsList = ({ groups }) => (
  <div>
    {groups.map(group => (
      <StyledCard key={group.id} imageURL={group.image_url}>
        <StyledCardBody>
          <StyledTitle href={group.id}>{group.name}</StyledTitle>
        </StyledCardBody>
      </StyledCard>
    ))}
  </div>
);

export default GroupsList;
