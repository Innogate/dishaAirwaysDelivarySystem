import { useRouter } from "expo-router";
import React, { useState } from "react";
import { View, Text, Pressable } from "react-native";
import Ionicons from "react-native-vector-icons/Ionicons";

const BottomNav = () => {
  const router = useRouter();
  const [activeIndex, setActiveIndex] = useState(0);

  function setActive(index: number, path: string) {
    setActiveIndex(index);
    router.push(path);
  }

  return (
    <View className="flex-row justify-around bg-white py-1 border-t border-gray-200">
      {/* Home */}
      <Pressable 
        className="items-center" 
        onPress={() => setActive(0, "/home")} 
        android_ripple={{ borderless: true, radius: 0 }}
      >
        <Ionicons name={activeIndex === 0 ? "home" : "home-outline"} size={24} color={activeIndex === 0 ? "#0d9488" : "#6b7280"} />
        <Text className={`text-xs mt-1 ${activeIndex === 0 ? "text-teal-600 font-bold" : "text-gray-500"}`}>Home</Text>
      </Pressable>

      {/* Booking */}
      <Pressable 
        className="items-center" 
        onPress={() => setActive(1, "/pages/booking")} 
        android_ripple={{ borderless: true, radius: 0 }}
      >
        <Ionicons name={activeIndex === 1 ? "book" : "book-outline"} size={24} color={activeIndex === 1 ? "#0d9488" : "#6b7280"} />
        <Text className={`text-xs mt-1 ${activeIndex === 1 ? "text-teal-600 font-bold" : "text-gray-500"}`}>Booking</Text>
      </Pressable>

      {/* Profile */}
      <Pressable 
        className="items-center" 
        onPress={() => setActive(2, "/login")} 
        android_ripple={{ borderless: true, radius: 0 }}
      >
        <Ionicons name={activeIndex === 2 ? "person" : "person-outline"} size={24} color={activeIndex === 2 ? "#0d9488" : "#6b7280"} />
        <Text className={`text-xs mt-1 ${activeIndex === 2 ? "text-teal-600 font-bold" : "text-gray-500"}`}>Profile</Text>
      </Pressable>
    </View>
  );
};

export default BottomNav;
