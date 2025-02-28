import React, { useState } from "react";
import { View, Text, TouchableOpacity, ScrollView, Dimensions } from "react-native";
import { FontAwesome5 } from "@expo/vector-icons";
import { useRouter } from "expo-router";
const { width } = Dimensions.get("window");

const menuItems = [
  { id: 1, title: "Company Master", icon: "users", screen: "/pages/master/company_master" },
  { id: 2, title: "Branch Master", icon: "building", screen: "/pages/master/branch_master" },
  { id: 3, title: "Employee Master", icon: "book-open", screen: "/pages/master/employee_master" },
  { id: 4, title: "User Master", icon: "book-open", screen: "/pages/master/user_master" },
  { id: 5, title: "States Master", icon: "book-open", screen: "/pages/master/states_master" },
  { id: 6, title: "City Master", icon: "book-open", screen: "/pages/master/city_master" },
];

const MenuGrid = () => {
  const [selected, setSelected] = useState(1);
  const router = useRouter();

  return (
    <View style={{ flex: 1, backgroundColor: "#f3f4f6", padding: 16 }}>
      <Text style={{ fontSize: 18, fontWeight: "bold", color: "#4b5563", marginBottom: 10 }}>
        Choose your area
      </Text>

      <ScrollView contentContainerStyle={{ paddingBottom: 20 }} showsVerticalScrollIndicator={false}>
        <View style={{ flexDirection: "row", flexWrap: "wrap", justifyContent: "space-between" }}>
          {menuItems.map((item) => (
            <TouchableOpacity
              key={item.id}
              onPress={() => {
                setSelected(item.id);
                if (item.screen) {
                  router.push(item.screen as any);
                  console.log("Navigating to:", item.screen);
                  // router.push(booking);
                }
              }}
              style={{
                width: width * 0.44,
                aspectRatio: 1,
                alignItems: "center",
                justifyContent: "center",
                padding: 15,
                borderRadius: 15,
                backgroundColor: selected === item.id ? "#6b21a8" : "#ffffff",
                shadowColor: "#000",
                shadowOffset: { width: 0, height: 2 },
                shadowOpacity: 0.2,
                shadowRadius: 4,
                elevation: 5,
                marginBottom: 10,
              }}
            >
              <FontAwesome5
                name={item.icon}
                size={28}
                color={selected === item.id ? "#ffffff" : "#6b21a8"}
              />
              <Text
                style={{
                  marginTop: 8,
                  fontWeight: "600",
                  color: selected === item.id ? "#ffffff" : "#6b21a8",
                }}
              >
                {item.title}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </ScrollView>
    </View>
  );
};

export default MenuGrid;