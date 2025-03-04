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
      if (token) {
        router.replace("/home");
      } else {
        router.replace("/login");
      }
    }
  }, [navigationState?.key, token]);

  return (
    <View style={{ flex: 1, justifyContent: "center", alignItems: "center", backgroundColor: "#3B82F6" }}>
      <Text style={{ color: "white", fontSize: 20, fontWeight: "bold", textAlign: "center" }}>
        This app is in development mode. If you encounter any issues, please contact the developer at{" "}
        <Text style={{ textDecorationLine: "underline" }}>innogate@yahoo.com</Text>.
      </Text>
    </View>
  );
}
