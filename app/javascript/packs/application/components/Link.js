import React from "react";
import styled from "styled-components";
import { Link as ReactRouterLink } from "react-router-dom";

const StyledLink = styled.a`
  color: inherit;
  text-decoration: none;
`;

const StyledReactRouterLink = styled(ReactRouterLink)`
  color: inherit;
  text-decoration: none;
`;

const Link = ({ to, children, ...rest }) => {
  // Regex from https://stackoverflow.com/a/19709846
  const r = new RegExp("^(?:[a-z]+:)?//", "i");
  const isAbsoluteLink = r.test(to);
  if (isAbsoluteLink) {
    return (
      <StyledLink href={to} target="_blank" {...rest}>
        {children}
      </StyledLink>
    );
  }
  return (
    <StyledReactRouterLink to={`/react/${to}`} {...rest}>
      {children}
    </StyledReactRouterLink>
  );
};

export default Link;
