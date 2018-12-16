import React from "react";
import { render } from "react-dom";

import HelloWorld from "../components/HelloWorld";

document.addEventListener("DOMContentLoaded", () => {
  const container = document.body.appendChild(document.createElement("div"));
  render(<HelloWorld name="Coffee" />, container);
});
