import { useEffect } from "react";
import { View, Text } from "react-native";
import { useRouter, useRootNavigationState } from "expo-router";
export default function LandingScreen() {
  const router = useRouter();
  const navigationState = useRootNavigationState();
  return (
    <View className="flex-1 justify-center items-center bg-blue-500">
      <Text className="text-white text-2xl font-bold">HOMESCREEN</Text>
    </View>
  )
}
