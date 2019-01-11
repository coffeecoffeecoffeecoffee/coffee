import React from "react";
import styled from "styled-components";

const StyledFooterBody = styled.div`
  border-top: 5px solid #000;
  margin: 0 auto;
  max-width: 1000px;
`;

const Footer = () => (
  <footer>
    <StyledFooterBody />
  </footer>
);

export default Footer;
