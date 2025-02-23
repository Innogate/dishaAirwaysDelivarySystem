// import { View, Text, TextInput, TouchableOpacity } from 'react-native';
// import AsyncStorage from '@react-native-async-storage/async-storage';
// import React from 'react';
// import { useRouter } from 'expo-router'; 
// // import "nativewind"; // Import NativeWind
// import "../global.css"

// const index = () => {
//   const router = useRouter();

//   const handleLogin = async () => {
//     await AsyncStorage.setItem('isLoggedIn', 'true'); 
//     const storedLoginStatus = await AsyncStorage.getItem('isLoggedIn');
//     console.log('Logged in', storedLoginStatus);
//     router.replace('tabs'); 
//   };

//   return (
//     <View className="flex-1 bg-white">
//       {/* Top Section */}
//       <View className="h-2/6 w-full bg-blue-400 rounded-b-full items-center justify-center">
//         <Text className="text-white text-2xl font-bold">WELCOME!!</Text>
//       </View>

//       {/* Login Form */}
//       <View className="flex-1 px-6 mt-10 gap-6">
//         <TextInput
//           className="w-full border border-gray-300 rounded-xl px-4 py-3 text-lg mb-4"
//           placeholder="Username / Email"
//         />

//         <TextInput
//           className="w-full border border-gray-300 rounded-xl px-4 py-3 text-lg mb-4"
//           placeholder="Password"
//           secureTextEntry
//         />

//         <TouchableOpacity 
//           className="w-full mt-16 py-4 bg-blue-500 rounded-full items-center" onPress={handleLogin}

//         >
//           <Text className="text-white text-lg font-semibold">Login</Text>
//         </TouchableOpacity>
//       </View>

//       {/* Bottom Rounded Decoration */}
//       <View className="h-32 mx-28 bg-blue-600 rounded-t-full items-center justify-center" />
//     </View>
//   );
// }

// export default index;

















// import React from 'react';
// import { View, Text, TextInput, TouchableOpacity } from 'react-native';
// import { useForm, Controller } from 'react-hook-form';
// import { yupResolver } from '@hookform/resolvers/yup';
// import * as yup from 'yup';
// import AsyncStorage from '@react-native-async-storage/async-storage';
// import { useRouter } from 'expo-router';
// import "../global.css"

// // ✅ Secure Form Validation Schema
// const loginSchema = yup.object().shape({
//   email: yup.string().email("Invalid email format").required("Email is required"),
//   password: yup
//     .string()
//     .min(6, "Password must be at least 6 characters")
//     .matches(/[a-zA-Z]/, "Must include at least one letter")
//     .matches(/[0-9]/, "Must include at least one number")
//     .required("Password is required"),
// });

// const index = () => {
//   const router = useRouter();

//   // ✅ React Hook Form Setup
//   const { control, handleSubmit, formState: { errors } } = useForm({
//     resolver: yupResolver(loginSchema),
//   });

//   // ✅ Handle Login (Save & Navigate)
//   const handleLogin = async (data) => {
//     console.log("Submitted Data:", data); // Log data before login
//     await AsyncStorage.setItem('isLoggedIn', 'true'); 
//     router.replace('tabs'); 
//   };

//   return (


//     <View className="flex-1 bg-white px-6 justify-center">
//       {/* 🟢 Title */}
//       <View className="items-center mb-6">
//         <Text className="text-blue-600 text-2xl font-bold">WELCOME!!</Text>
//       </View>

//       {/* 🟢 Email Field */}
//       <Controller
//         control={control}
//         name="email"
//         render={({ field: { onChange, onBlur, value } }) => (
//           <TextInput
//             className="w-full border border-gray-300 rounded-xl px-4 py-3 text-lg mb-1"
//             placeholder="Username / Email"
//             onBlur={onBlur}
//             onChangeText={onChange}
//             value={value}
//             keyboardType="email-address"
//             autoCapitalize="none"
//           />
//         )}
//       />
//       {errors.email && <Text className="text-red-500 text-sm mb-4">{errors.email.message}</Text>}

//       {/* 🟢 Password Field */}
//       <Controller
//         control={control}
//         name="password"
//         render={({ field: { onChange, onBlur, value } }) => (
//           <TextInput
//             className="w-full border border-gray-300 rounded-xl px-4 py-3 text-lg mb-1"
//             placeholder="Password"
//             secureTextEntry
//             onBlur={onBlur}
//             onChangeText={onChange}
//             value={value}
//           />
//         )}
//       />
//       {errors.password && <Text className="text-red-500 text-sm mb-4">{errors.password.message}</Text>}

//       {/* 🟢 Login Button */}
//       <TouchableOpacity 
//         className="w-full mt-6 py-4 bg-blue-500 rounded-full items-center"  
//         onPress={handleSubmit(handleLogin)}
//       >
//         <Text className="text-white text-lg font-semibold">Login</Text>
//       </TouchableOpacity>
//     </View>
//   );
// }

// export default index;


import React from 'react';
import { View, Text, TextInput, TouchableOpacity, Image } from 'react-native';
import { useForm, Controller } from 'react-hook-form';
import { yupResolver } from '@hookform/resolvers/yup';
import * as yup from 'yup';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { useRouter } from 'expo-router';
// import "nativewind"; // Ensure NativeWind is installed
import "../global.css"

// ✅ Form Validation Schema
const loginSchema = yup.object().shape({
  email: yup.string().email("Invalid email format").required("Email is required"),
  password: yup.string().min(6, "At least 6 characters required").required("Password is required"),
});

const LoginScreen = () => {
  const router = useRouter();

  // ✅ React Hook Form Setup
  const { control, handleSubmit, formState: { errors } } = useForm({
    resolver: yupResolver(loginSchema),
  });

  // ✅ Handle Login
  const handleLogin = async (data) => {
    console.log("Submitted Data:", data);
    await AsyncStorage.setItem('isLoggedIn', 'true');
    router.replace('tabs');
  };

  return (
    <View className="flex-1 bg-white">

      {/* 🟢 Header with Logo */}
      <View className="h-3/5 bg-orange-600 items-center">
        <View className="bg-white rounded-xl p-2 mt-[6rem]">
          <Image source={require("../assets/images/icon.png")} className="w-12 h-12" />
        </View>
      </View>



      {/* 🟢 Overlapping Login Form */}
      <View className="absolute top-1/3 left-0 right-0 bg-white rounded-tl-[15%] px-6 py-10">
        <Text className="text-black text-2xl font-semibold text-center mb-6">Login</Text>

        {/* Email Field */}
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

        {/* Password Field */}
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

        {/* Login Button */}
        <TouchableOpacity
          className="w-full mt-6 py-4 bg-black rounded-xl items-center"
          onPress={handleSubmit(handleLogin)}
        >
          <Text className="text-white text-lg font-semibold">Login</Text>
        </TouchableOpacity>

        {/* Sign-Up Link */}
        <Text className="text-gray-500 text-center mt-6">
          Don’t have an account? <Text className="text-black font-bold">Sign Up</Text>
        </Text>
      </View>
    </View>
  );
}

export default LoginScreen;
