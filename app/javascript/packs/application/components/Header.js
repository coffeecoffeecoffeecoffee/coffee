import React from "react";
import styled from "styled-components";
import { Link } from "react-router-dom";
import { fonts } from "../constants";

const StyledHeader = styled.header`
  align-items: center;
  display: grid;
  font-family: ${fonts.default};
  font-size: 38px;
  font-weight: 600;
`;

const StyledLink = styled(Link)`
  color: inherit;
  text-decoration: none;
`;

const Header = () => (
  <StyledHeader>
    <StyledLink to="/react">Coffee</StyledLink>
  </StyledHeader>
);

export default Header;
