import { useEffect } from "react";
import { View, Text } from "react-native";
import { useRouter, useRootNavigationState } from "expo-router";
import globalStorage from "./components/GlobalStorage";
import '../global.css'
import React from "react";
export default async function LandingScreen() {
  const router = useRouter();
  const navigationState = useRootNavigationState();
  globalStorage.setTemp("pageTitle","Login");
  const token = await globalStorage.getValue("token")
  useEffect(() => {
    if (!token) {
      router.push("/login");
      return;
    }
    router.push("/home");
  }, [navigationState?.key]);
  return (
    <View className="flex-1 justify-center items-center bg-blue-500">
      <Text className="text-white text-2xl font-bold">This app in devolvement mode application Malfunction pls contact developer for fix this. or conduct innogate@yhaoo.com</Text>
    </View>
  );
}
