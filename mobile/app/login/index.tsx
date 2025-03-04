import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  Image,
  StyleSheet,
  Alert,
} from "react-native";
import { useForm, Controller } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";
import * as yup from "yup";
import { useRouter } from "expo-router";
import { API_BASE_URL } from "@/constants/api.url";
import globalStorage from "../components/GlobalStorage";

// Validation Schema
const loginSchema = yup.object().shape({
  email: yup.string().required("User ID is required"),
  password: yup.string().min(4, "At least 4 characters required").required("Password is required"),
});

const LoginScreen = () => {
  const router = useRouter();
  const [emailError, setEmailError] = useState("");
  const [passwordError, setPasswordError] = useState("");
  
  const { control, handleSubmit, formState: { errors } } = useForm({
    resolver: yupResolver(loginSchema),
  });

  const handleLogin = async (data: any) => {
    setEmailError("");
    setPasswordError("");

    const url = API_BASE_URL + "/login";
    const header = { "Content-Type": "application/json" };

    const body = JSON.stringify({
      id: data.email,
      passwd: data.password,
    });

    try {
      const res = await fetch(url, {
        method: "POST",
        headers: header,
        body: body,
      });

      if (res.status === 200) {
        const response = await res.json();
        if (response.body.token) {
          globalStorage.setPermanent("token", response.body.token);
          router.replace("home");
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
      Alert.alert("Error", error);
      setEmailError("Something went wrong. Please try again.");
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <View style={styles.imageContainer}>
          <Image
            source={require("../../assets/images/logo.jpeg")}
            style={styles.image}
            resizeMode="contain"
          />
        </View>
      </View>

      <View style={styles.formContainer}>
        <Text style={styles.title}>Login</Text>

        {/* Email Input */}
        <Text style={styles.label}>Email</Text>
        <Controller
          control={control}
          name="email"
          render={({ field: { onChange, onBlur, value } }) => (
            <TextInput
              style={styles.input}
              placeholder="Enter email"
              onBlur={onBlur}
              onChangeText={onChange}
              value={value}
              keyboardType="email-address"
              autoCapitalize="none"
            />
          )}
        />
        {errors.email && <Text style={styles.errorText}>{errors.email.message}</Text>}
        {emailError && <Text style={styles.errorText}>{emailError}</Text>}

        {/* Password Input */}
        <Text style={styles.label}>Password</Text>
        <Controller
          control={control}
          name="password"
          render={({ field: { onChange, onBlur, value } }) => (
            <TextInput
              style={styles.input}
              placeholder="Enter password"
              secureTextEntry
              onBlur={onBlur}
              onChangeText={onChange}
              value={value}
            />
          )}
        />
        {errors.password && <Text style={styles.errorText}>{errors.password.message}</Text>}
        {passwordError && <Text style={styles.errorText}>{passwordError}</Text>}

        {/* Login Button */}
        <TouchableOpacity style={styles.button} onPress={handleSubmit(handleLogin)}>
          <Text style={styles.buttonText}>Login</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

// Styles
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white",
  },
  header: {
    height: "60%",
    backgroundColor: "#6B21A8",
    // justifyContent: "center",
    alignItems: "center",
  },
  imageContainer: {
    backgroundColor: "white",
    padding: 10,
    borderRadius: 100, // Ensure container is also round
    marginTop: 60,
  },
  image: {
    width: 70,
    height: 70,
    alignSelf: "center",
    borderRadius: 75, // Make it fully round
  },

  formContainer: {
    position: "absolute",
    top: "40%",
    left: 0,
    right: 0,
    backgroundColor: "white",
    borderTopLeftRadius: 40,
    paddingHorizontal: 24,
    paddingVertical: 40,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 16,
    color: "black",
  },
  label: {
    fontSize: 14,
    color: "#6B7280",
    marginBottom: 4,
  },
  input: {
    width: "100%",
    borderWidth: 1,
    borderColor: "#D1D5DB",
    backgroundColor: "#F3F4F6",
    borderRadius: 12,
    paddingVertical: 12,
    paddingHorizontal: 16,
    fontSize: 16,
    marginBottom: 8,
  },
  errorText: {
    color: "red",
    fontSize: 14,
    marginBottom: 8,
  },
  button: {
    width: "100%",
    marginTop: 40,
    paddingVertical: 14,
    backgroundColor: "#F59E0B",
    borderRadius: 12,
    alignItems: "center",
  },
  buttonText: {
    color: "white",
    fontSize: 18,
    fontWeight: "bold",
  },
});

export default LoginScreen;
