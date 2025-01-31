import TestableButton from "@/components/TestableButton";
import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";

test("renders a button with the correct text", () => {
  render(<TestableButton>Click me</TestableButton>);
  const button = screen.getByTestId("testable-button");
  expect(button).toBeInTheDocument();
});
