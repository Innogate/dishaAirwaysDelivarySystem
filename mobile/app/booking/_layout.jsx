import { Stack } from "expo-router";

export default function BookingLayout() {
  return (
    <Stack>
      <Stack.Screen name="index" options={{ title: "Booking Entry" }} />
      <Stack.Screen name="bookinglist" options={{ title: "Booking List" }} />
    </Stack>
  );
}
