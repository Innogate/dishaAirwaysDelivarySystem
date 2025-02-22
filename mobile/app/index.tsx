import { View, Text, TextInput, TouchableOpacity, ImageBackground } from 'react-native'
import AsyncStorage from "@react-native-async-storage/async-storage";

import React from 'react'
import { useRouter } from "expo-router"; // Import useRouter for navigation
import "../global.css"
const index = () => {
  const router = useRouter();

  const handleLogin = async () => {
    await AsyncStorage.setItem("isLoggedIn", "true"); // Store login state
    const storedLoginStatus = await AsyncStorage.getItem("isLoggedIn");
    console.log("Logged in", storedLoginStatus);
    router.replace("tabs"); // Navigate to home screen
  };

    return (
        // <View>
        <View className="flex-1 bg-white">
      {/* Top Section */}
      <View className="h-2/6 w-full  bg-gradient-to-r from-blue-400 to-purple-500 rounded-b-full items-center justify-center">
        <Text className="text-white text-2xl font-bold">WELCOME!!</Text>
      </View>

      {/* Login Form */}
      <View className="flex-1 px-6 mt-10 gap-6">
        <TextInput
          className="w-full border border-gray-300 rounded-xl px-4 py-3 text-lg mb-4"
          placeholder="Username / Email"
        />

        <TextInput
          className="w-full border border-gray-300 rounded-xl px-4 py-3 text-lg mb-4"
          placeholder="Password"
          secureTextEntry
        />
        <TouchableOpacity className="w-full mt-[8vh] py-4 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full items-center"  onPress={handleLogin}>
          <Text className="text-white text-lg font-semibold">Login</Text>
        </TouchableOpacity>
      </View>

      {/* Login Button Positioned at the Bottom */}
      
      {/* Bottom Rounded Decoration */}
      <View className="h-32 mx-28 bg-gradient-to-r from-blue-400 to-blue-600 rounded-t-full items-center justify-center"></View>
    </View>
  );

}


export default index