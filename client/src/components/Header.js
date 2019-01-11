import React from "react";
import styled from "styled-components";
import { fonts } from "../constants";

const StyledHeader = styled.header`
  align-items: center;
  display: grid;
  font-family: ${fonts.default};
  font-size: 38px;
  font-weight: 500;
`;

const Header = () => (
  <StyledHeader>
    <span>Coffee</span>
  </StyledHeader>
);

export default Header;
