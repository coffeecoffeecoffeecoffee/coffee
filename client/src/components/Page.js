import React from "react";
import styled from "styled-components";

const StyledPage = styled.div`
  padding: 0 70px;
`;

const Page = ({ children }) => <StyledPage>{children}</StyledPage>;

export default Page;
