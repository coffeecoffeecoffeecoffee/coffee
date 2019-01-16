import React from "react";
import styled from "styled-components";
import Link from "./Link";
import Time from "./Time";
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

const StyledTitleLink = styled(Link)`
  font-family: ${fonts.default};
  font-size: 36px;
  font-weight: 500;
  word-wrap: break-word;

  @media (min-width: ${breakpoints.sm}) {
    font-size: 48px;
  }
`;

const StyledTime = styled(Time)`
  font-family: ${fonts.default};
`;

const ImageCard = ({ imageURL, url, title, time }) => (
  <StyledCard imageURL={imageURL}>
    <StyledCardBody>
      <StyledTitleLink to={url}>{title}</StyledTitleLink>
      <br />
      {time !== undefined ? <StyledTime time={time} /> : null}
    </StyledCardBody>
  </StyledCard>
);

export default ImageCard;
