import { useEffect, useState } from "react";
import { View, Text, Alert } from "react-native";
import { useRouter, useRootNavigationState } from "expo-router";
import globalStorage from "./components/GlobalStorage";
import "../global.css";
import React from "react";
import { API_BASE_URL } from "../constants/api.url";

export default function LandingScreen() {
  const router = useRouter();
  const navigationState = useRootNavigationState();
  const [token, setToken] = useState<string | null>(null);

  useEffect(() => {
    globalStorage.setTemp("pageTitle", "Login");

    const checkToken = async () => {
      const storedToken = await globalStorage.getValue("token");
      setToken(storedToken); // Store token in state
      if (storedToken) {
        await verifyToken(storedToken);
      } else {
        router.replace("/login");
      }
    };

    checkToken();
  }, []);

  const verifyToken = async (storedToken: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/verify`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${storedToken}`,
        },
      });

      const data = await response.json(); // Parse response body

      if (response.status === 200) {
        Alert.alert("Success", data.message || "Token Verified!", [
          { text: "OK", onPress: () => router.replace("/home") },
        ]);
      } else {
        await globalStorage.destroy(); // Remove token
        Alert.alert("Error", data.message || "Invalid token. Logging out...", [
          { text: "OK", onPress: () => router.replace("/login") },
        ]);
      }
    } catch (error) {
      console.error("Verification failed:", error);
      await globalStorage.destroy();
      router.replace("/login");
    }
  };

  return (
    <View style={{ flex: 1, justifyContent: "center", alignItems: "center", backgroundColor: "#3B82F6" }}>
      <Text style={{ color: "white", fontSize: 20, fontWeight: "bold", textAlign: "center" }}>
        This app is in development mode. If you encounter any issues, please contact the developer at{" "}
        <Text style={{ textDecorationLine: "underline" }}>innogate@yahoo.com</Text>.
      </Text>
    </View>
  );
}
