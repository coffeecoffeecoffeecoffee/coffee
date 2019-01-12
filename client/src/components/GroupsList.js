import React from "react";
import styled from "styled-components";
import { breakpoints, colors, fonts } from "../constants";

const StyledCard = styled.div`
  background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
    url(${props => props.imageURL || ""});
  background-size: cover;
  border-radius: 10px;
  color: ${colors.white};
  height: 350px;
  margin: 40px auto;
  max-width: 350px;
  padding: 20px;
  text-align: center;

  @media (min-width: ${breakpoints.sm}) {
    height: 500px;
    max-width: 500px;
  }
`;

const StyledCardBody = styled.div`
  position: relative;
  top: 50%;
  transform: perspective(1px) translateY(-50%);
`;

const StyledTitle = styled.a`
  color: inherit;
  font-family: ${fonts.default};
  font-size: 36px;
  font-weight: 500;
  text-decoration: none;
  word-wrap: break-word;

  @media (min-width: ${breakpoints.sm}) {
    font-size: 48px;
  }
`;

const GroupsList = ({ groups }) => (
  <div>
    {groups.map(group => (
      <StyledCard key={group.id} imageURL={group.image_url}>
        <StyledCardBody>
          <StyledTitle href={group.slug}>{group.name}</StyledTitle>
        </StyledCardBody>
      </StyledCard>
    ))}
  </div>
);

export default GroupsList;
