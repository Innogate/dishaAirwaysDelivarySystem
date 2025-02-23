import React, { useState } from "react";
import { View, Text, TouchableOpacity, ScrollView, StyleSheet } from "react-native";
import { TextInput } from "react-native-paper";
import { SelectList } from "react-native-dropdown-select-list";

const BookingScreen = () => {
  const [form, setForm] = useState({
    consignee: "",
    origin: "",
    destination: "",
    phone: "",
    transportType: "",
    declaredValue: "",
    weight: "",
    contain: "",
    charges: "",
    shipper: "",
    cgst: "",
    sgst: "",
    igst: "",
    totalValue: "",
  });

  return (
    <ScrollView className="flex-1 bg-white p-4">
      {/* Header */}
      <Text className="text-lg font-bold mb-4">JUNE 2025</Text>

      {/* Form Fields */}
      <TextInput
        label="Consignee"
        value={form.consignee}
        onChangeText={(text) => setForm({ ...form, consignee: text })}
        mode="outlined"
        style={styles.input} // Same global style applied
        contentStyle={styles.inputContent}
      />

      <TextInput
        label="Origin"
        value={form.origin}
        onChangeText={(text) => setForm({ ...form, origin: text })}
        mode="outlined"
        style={styles.input} // Same global style applied
        contentStyle={styles.inputContent}
      />
      <TextInput
        label="Destination"
        value={form.destination}
        onChangeText={(text) => setForm({ ...form, destination: text })}
        mode="outlined"
        style={styles.input} // Same global style applied
        contentStyle={styles.inputContent}
      />
      <TextInput
        label="Phone Number"
        value={form.phone}
        onChangeText={(text) => setForm({ ...form, phone: text })}
        mode="outlined"
        keyboardType="phone-pad"
        style={styles.input} // Same global style applied
        contentStyle={styles.inputContent}
      />

      {/* Transport Type Dropdown */}
      <View className="relative w-full mb-2">
        <SelectList
          data={[
            { key: "1", value: "Air" },
            { key: "2", value: "Road" },
          ]}
          boxStyles={{ width: "100%", marginTop: 6 }}
          dropdownStyles={{
            width: "100%",
            position: "absolute",
            top: 45,
            zIndex: 10,
            backgroundColor: "black",
          }}
          placeholder="Transport Type"
          setSelected={(val) => setForm({ ...form, transportType: val })}
        />
      </View>

      {/* Weight & Declared Value */}
      <View style={stylesin.container}>
        {/* Responsive Input Fields */}
        <View className="flex-row w-full space-x-4 gap-2">
          <TextInput
            label="Declared Value"
            value={form.declaredValue}
            onChangeText={(text) => setForm({ ...form, declaredValue: text })}
            mode="outlined"
            keyboardType="numeric"
            style={stylesin.input} // Apply global style
          />
          <TextInput
            label="Weight"
            value={form.weight}
            onChangeText={(text) => setForm({ ...form, weight: text })}
            mode="outlined"
            keyboardType="numeric"
            style={stylesin.input} // Apply global style
          />
        </View>
      </View>

      {/* Charges Section */}
      <View style={stylesthreefield.container}>
        {/* Responsive Input Fields */}
        <View className="flex-row w-full space-x-3 gap-2">
          <TextInput
            label="Contain"
            value={form.contain}
            onChangeText={(text) => setForm({ ...form, contain: text })}
            mode="outlined"
            style={stylesthreefield.input} // Apply global style
          />
          <TextInput
            label="Charges"
            value={form.charges}
            onChangeText={(text) => setForm({ ...form, charges: text })}
            mode="outlined"
            keyboardType="numeric"
            style={stylesthreefield.input} // Apply global style
          />
          <TextInput
            label="Shipper's"
            value={form.shipper}
            onChangeText={(text) => setForm({ ...form, shipper: text })}
            mode="outlined"
            keyboardType="numeric"
            style={stylesthreefield.input} // Apply global style
          />
        </View>

      </View>

      {/* Tax Fields */}
      <View style={stylesthreefield.container}>
        <View className="flex-row w-full space-x-3 gap-2">

          <TextInput
            label="CGST"
            value={form.cgst}
            onChangeText={(text) => setForm({ ...form, cgst: text })}
            mode="outlined"
            keyboardType="numeric"
            // className="w-1/3"
            style={stylesthreefield.input}
          />
          <TextInput
            label="SGST"
            value={form.sgst}
            onChangeText={(text) => setForm({ ...form, sgst: text })}
            mode="outlined"
            keyboardType="numeric"
            // className="w-1/3"
            style={stylesthreefield.input}
          />
          <TextInput
            label="IGST"
            value={form.igst}
            onChangeText={(text) => setForm({ ...form, igst: text })}
            mode="outlined"
            keyboardType="numeric"
            // className="w-1/3"
            style={stylesthreefield.input}
          />
        </View>
      </View>

      {/* Total Value */}
      <TextInput
        label="Total Value"
        value={form.totalValue}
        onChangeText={(text) => setForm({ ...form, totalValue: text })}
        mode="outlined"
        keyboardType="numeric"

        style={styles.input} // Same global style applied
        contentStyle={styles.inputContent}
      />

      {/* Submit Button */}
      <TouchableOpacity className="bg-teal-500 p-3 rounded items-center mt-10">
        <Text className="text-white font-bold">SUBMIT</Text>
      </TouchableOpacity>

      {/* Spacer */}
      <View className="h-20"></View>
    </ScrollView>
  );
};





const styles = StyleSheet.create({
  input: {
    paddingVertical: 0,
    paddingHorizontal: 0,
    margin: 0,
    fontSize: 10,
    height: 40, // Adjust input height globally
  },
  inputContent: {
    paddingVertical: 0,
    paddingHorizontal: 0,
  },
});



const stylesin = StyleSheet.create({
  container: {
    flex: 1,
    // paddingHorizontal: 16, // Ensures proper spacing on all screens
    // backgroundColor: "white",
    // justifyContent: "center",
  },
  input: {
    flex: 1, // Ensures equal width & expansion
    // borderWidth: 1,
    // borderColor: "#ccc",
    borderRadius: 8,
    paddingVertical: 0, // Adjusts inner padding
    paddingHorizontal: 0,
    margin: 0,
    height: 40,
    fontSize: 10,
    minWidth: 120, // Ensures a minimum size
    maxWidth: "50%", // Allows expansion up to half the screen
  },
});





const stylesthreefield = StyleSheet.create({
  container: {
    flex: 1,
  },
  input: {
    flex: 1, // Distributes space equally among inputs
    borderRadius: 8,
    paddingVertical: 0, // Adjusts inner padding
    paddingHorizontal: 0,
    margin: 0,
    height: 40,
    fontSize: 10,
    minWidth: 100, // Ensures a minimum size
    maxWidth: "33%", // Ensures each field takes 1/3 of screen
  },
});

export default BookingScreen;
