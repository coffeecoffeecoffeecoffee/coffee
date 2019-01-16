import React from "react";
import styled from "styled-components";
import { breakpoints } from "../constants";

import "normalize.css";
import "../assets/css/fonts.css";

const StyledPage = styled.div`
  display: grid;
  grid-template-areas:
    "header"
    "main"
    "footer";
  grid-template-rows: 80px 1fr 80px;
  padding: 0 20px;

  @media (min-width: ${breakpoints.sm}) {
    padding: 0 70px;
  }
`;
const Page = ({ children }) => <StyledPage>{children}</StyledPage>;

export default Page;
