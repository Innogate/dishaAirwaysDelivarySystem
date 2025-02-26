import React, { useState} from 'react';
import { View, Text, TextInput, TouchableOpacity, Image } from 'react-native';
import { useRouter } from 'expo-router';


const LoginScreen = () => {
  const router = useRouter();

  const handleLogin = async (data: any) => {

    console.log("Submitted Data:", data);
    // await AsyncStorage.setItem('isLoggedIn', 'true');
    // router.replace('tabs');
  };

  return (
    <View className="flex-1 bg-white">

      <Text>Login PAGE</Text>
    </View>
  );
}

export default LoginScreen;