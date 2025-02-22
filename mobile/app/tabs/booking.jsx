import React from "react";
import { View, Text, Button } from "react-native";
import { useNavigation } from "@react-navigation/native";

const booking = () => {
  const navigation = useNavigation();

  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Text style={{ fontSize: 20, fontWeight: "bold", marginBottom: 20 }}>
        Welcome to Booking Page
      </Text>
      <Button title="Go Back" onPress={() => navigation.goBack()} />
    </View>
  );
};

export default booking;
