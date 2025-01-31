import TestableButton from "@/components/TestableButton";
import { Button } from "@heroui/button";

export default function Page() {
  return (
    <div className="p-8">
      <h1 className="text-3xl">NextJS Jest Demo App</h1>

      <div className="flex gap-2 my-2">
        <Button color="secondary">Click Me</Button>
        <TestableButton>Testable</TestableButton>
      </div>
    </div>
  );
}
