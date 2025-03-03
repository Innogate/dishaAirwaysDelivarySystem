import { useEffect, useState } from "react";
import { View, Text } from "react-native";
import { useRouter, useRootNavigationState } from "expo-router";
import globalStorage from "./components/GlobalStorage";
import "../global.css";
import React from "react";

export default function LandingScreen() {
  const router = useRouter();
  const navigationState = useRootNavigationState();
  const [token, setToken] = useState<string | null>(null);

  useEffect(() => {
    globalStorage.setTemp("pageTitle", "Login");

    const checkToken = async () => {
      const storedToken = await globalStorage.getValue("token");
      setToken(storedToken);
    };

    checkToken();
  }, []);

  useEffect(() => {
    if (navigationState?.key && token !== null) {
      if (!token) {
        router.replace("/login");
      } else {
        router.replace("/home");
      }
    }
  }, [navigationState?.key, token]);

  return (
    <View className="flex-1 justify-center items-center bg-blue-500">
      <Text className="text-white text-2xl font-bold">
        This app is in development mode. If you encounter any issues, please
        contact the developer at{" "}
        <Text className="underline">innogate@yahoo.com</Text>.
      </Text>
    </View>
  );
}
