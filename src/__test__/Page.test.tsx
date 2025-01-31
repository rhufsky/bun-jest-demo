import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import Page from "@/app/page";

test("renders a page", () => {
  render(<Page />);
  const header = screen.getByRole("heading");
  expect(header).toBeInTheDocument();
});
