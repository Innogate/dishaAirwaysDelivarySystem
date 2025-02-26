import React, { useRef } from 'react';
import { View, Text, TextInput, TouchableOpacity, Image } from 'react-native';
import { useForm, Controller } from 'react-hook-form';
import { yupResolver } from '@hookform/resolvers/yup';
import * as yup from 'yup';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { useRouter } from 'expo-router';
import AlertPro from 'react-native-alert-pro';
import "../global.css";

const loginSchema = yup.object().shape({
  email: yup.string().required("User ID is required"),
  password: yup.string().min(6, "At least 6 characters required").required("Password is required"),
});

const LoginScreen = () => {
  const router = useRouter();
  const alertRef = useRef(null);

  // ✅ React Hook Form Setup
  const { control, handleSubmit, formState: { errors } } = useForm({
    resolver: yupResolver(loginSchema),
  });

  // ✅ Handle Login
  const handleLogin = async (data: any) => {
    alertRef.current.open();

    setTimeout(async () => {
      alertRef.current.close();
      // await AsyncStorage.setItem('isLoggedIn', 'true');
      // router.replace('tabs'); // ✅ Navigate after alert
    }, 2000);
  };

  return (
    <View className="flex-1 bg-white">

      <View className="h-3/5 bg-orange-600 items-center">
        <View className="bg-white rounded-xl p-2 mt-[6rem]">
          <Image source={require("../assets/images/icon.png")} className="w-12 h-12" />
        </View>
      </View>

      <View className="absolute top-1/3 left-0 right-0 bg-white rounded-tl-[15%] px-6 py-10">
        <Text className="text-black text-2xl font-semibold text-center mb-6">Login</Text>
        <Text className="text-gray-500 mb-1">Email</Text>
        <Controller
          control={control}
          name="email"
          render={({ field: { onChange, onBlur, value } }) => (
            <TextInput
              className="w-full border border-gray-300 bg-gray-100 rounded-xl px-4 py-3 text-lg"
              placeholder="Enter email"
              onBlur={onBlur}
              onChangeText={onChange}
              value={value}
              keyboardType="email-address"
              autoCapitalize="none"
            />
          )}
        />
        {errors.email && <Text className="text-red-500 text-sm mb-3">{errors.email.message}</Text>}

        <Text className="text-gray-500 mb-1 mt-3">Password</Text>
        <Controller
          control={control}
          name="password"
          render={({ field: { onChange, onBlur, value } }) => (
            <TextInput
              className="w-full border border-gray-300 bg-gray-100 rounded-xl px-4 py-3 text-lg"
              placeholder="Enter password"
              secureTextEntry
              onBlur={onBlur}
              onChangeText={onChange}
              value={value}
            />
          )}
        />
        {errors.password && <Text className="text-red-500 text-sm mb-4">{errors.password.message}</Text>}

        <TouchableOpacity
          className="w-full mt-6 py-4 bg-black rounded-xl items-center"
          onPress={handleSubmit(handleLogin)}
        >
          <Text className="text-white text-lg font-semibold">Login</Text>
        </TouchableOpacity>

        <AlertPro
          ref={alertRef}
          title="Success!"
          message="Login successful!"
          showConfirm
          textConfirm="OK"
          onConfirm={() => alertRef.current.close()}
          customStyles={{
            mask: { backgroundColor: 'rgba(0, 0, 0, 0.5)' },
            container: { borderWidth: 2, borderColor: '#4CAF50', borderRadius: 10 },
            buttonConfirm: { backgroundColor: '#4CAF50' },
          }}
        />

        <Text className="text-gray-500 text-center mt-6">
          Don’t have an account? <Text className="text-black font-bold">Sign Up</Text>
        </Text>
      </View>
    </View>
  );
};

export default LoginScreen;
