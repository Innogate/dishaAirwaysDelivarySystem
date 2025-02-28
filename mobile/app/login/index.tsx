import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity } from 'react-native';
import { useForm, Controller } from 'react-hook-form';
import { yupResolver } from '@hookform/resolvers/yup';
import * as yup from 'yup';
import { useRouter } from 'expo-router';
import { environment } from '../environment/environment';
import globalStorage from '../components/GlobalStorage';
const loginSchema = yup.object().shape({
  email: yup.string().required("User ID is required"),
  password: yup.string().min(4, "At least 4 characters required").required("Password is required"),
});


const LoginScreen = () => {
  const router = useRouter();
  const [emailError, setEmailError] = useState(""); // Email-specific error
  const [passwordError, setPasswordError] = useState(""); // Password-specific error
  const { control, handleSubmit, formState: { errors } } = useForm({
    resolver: yupResolver(loginSchema),
  });

  const handleLogin = async (data: any) => {
    // Reset errors before request
    setEmailError("");
    setPasswordError("");

    const url = environment.apiUrl + '/login';
    const header = {
      'Content-Type': 'application/json',
    };

    const body = JSON.stringify({
      "id": data.email,
      "passwd": data.password
    });

    try {
      const res = await fetch(url, {
        method: 'POST',
        headers: header,
        body: body
      });
      if (res.status === 200) {
        const response = await res.json();
        if (response.body.token) {
          globalStorage.setPermanent('token', response.body.token);
          router.replace('home');
        }
      } else {
        const errorResponse = await res.json();
        if (errorResponse.message.includes("User ID not matched")) {
          setEmailError("User ID not matched");
        } else if (errorResponse.message.includes("Password not matched")) {
          setPasswordError("Password not matched");
        } else {
          setEmailError("Invalid credentials");
        }
      }
    } catch (error) {
      setEmailError("Something went wrong. Please try again.");
    }
  };

  return (
    <View className="flex-1 bg-white">
      <View className="h-3/5 bg-purple-600 items-center">
        <View className="bg-white rounded-xl p-2 mt-[6rem]"></View>
      </View>
      <View className="absolute top-1/3 left-0 right-0 bg-white rounded-tl-[15%] px-6 py-10">
        <Text className="text-black text-2xl font-semibold text-center mb-6">Login</Text>

        {/* Email Input */}
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
        {errors.email && <Text className="text-red-500 text-sm mb-1">{errors.email.message}</Text>}
        {emailError && <Text className="text-red-500 text-sm mb-3">{emailError}</Text>}

        {/* Password Input */}
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
        {errors.password && <Text className="text-red-500 text-sm mb-1">{errors.password.message}</Text>}
        {passwordError && <Text className="text-red-500 text-sm mb-3">{passwordError}</Text>}

        {/* Login Button */}
        <TouchableOpacity
          className="w-full mt-20 py-4 bg-amber-500 rounded-xl items-center"
          onPress={handleSubmit(handleLogin)}
        >
          <Text className="text-white text-lg font-semibold">Login</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

export default LoginScreen;
