"use client";

import { Button } from "@heroui/button";
import { useState } from "react";

export default function TestableButton({
  children,
}: {
  children: React.ReactNode;
}) {
  const [clicked, setClicked] = useState(false);
  const handlePress = () => {
    setClicked((oldValue) => !oldValue);
  };
  return (
    <Button color="danger" onPress={handlePress} data-testid="testable-button">
      {children} {clicked ? "Yep" : "Nope"}
    </Button>
  );
}
