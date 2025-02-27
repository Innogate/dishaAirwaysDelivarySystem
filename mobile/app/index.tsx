import { useEffect } from "react";
import { View, Text } from "react-native";
import { useRouter, useRootNavigationState } from "expo-router";
import globalStorage from "./components/GlobalStorage";
import '../global.css'
export default function LandingScreen() {
  const router = useRouter();
  const navigationState = useRootNavigationState();
  globalStorage.setTemp("pageTitle","Login")
  useEffect(() => {
    if (navigationState?.key) {
      router.push("/login");
      return;
    }
  }, [navigationState?.key]);
  return (
    <View className="flex-1 justify-center items-center bg-blue-500">
      <Text className="text-white text-2xl font-bold">This application Mailfunctiond pls conntuct devloper for fix this. or contuct innogate@yhaoo.com</Text>
    </View>
  );
}
