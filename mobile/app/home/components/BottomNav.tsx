import { View, TouchableOpacity, Text } from "react-native";
import { useRouter } from "expo-router";
import React, { useState } from "react";
import { Ionicons } from "@expo/vector-icons";

export default function BottomNav() {
  const router = useRouter();
  const [activeIndex, setActiveIndex] = useState(0);

  const routes = [
    { key: "home", title: "Home", icon: "home-outline", activeIcon: "home", path: "/" },
    { key: "booking", title: "Booking", icon: "book-outline", activeIcon: "book", path: "/booking" },
    { key: "create", title: "Create", icon: "add-circle-outline", activeIcon: "add-circle", path: "/create" },
    { key: "profile", title: "Profile", icon: "person-outline", activeIcon: "person", path: "/profile" },
  ];

  const handleTabPress = (index: number) => {
    setActiveIndex(index);
    router.push(routes[index].path);
  };

  return (
    <View className="flex-row absolute bottom-3 left-5 right-5 bg-white rounded-2xl shadow-lg h-16 items-center justify-around">
      {routes.map((route, i) => (
        <TouchableOpacity key={route.key} className="items-center" onPress={() => handleTabPress(i)}>
          <Ionicons name={activeIndex === i ? route.activeIcon : route.icon} size={24} color={activeIndex === i ? "#0d9488" : "#6b7280"} />
          <Text className={`text-xs mt-1 ${activeIndex === i ? "text-teal-600 font-bold" : "text-gray-500"}`}>
            {route.title}
          </Text>
        </TouchableOpacity>
      ))}
    </View>
  );
}
