import { View, Text, TextInput, Image, TouchableOpacity } from "react-native";

export default function ProfileScreen() {
  return (
    <View className="flex-1 items-center  bg-gray-100">
      {/* Profile Picture */}
      <View className="relative w-24 h-24 my-9 rounded-full">
        <Image
          source={require("../../assets/images/react-logo.png")} // Local image
          style={{ width: 96, height: 96, resizeMode: "cover", borderRadius: 10 }}
        />
        {/* <TouchableOpacity className="absolute bottom-0 right-0 bg-black p-2 rounded-full">
          <Text className="text-white">✏️</Text>
        </TouchableOpacity> */}
      </View>

      {/* Profile Form */}
      <View className="w-full max-w-md p-6 rounded-lg ">
        <View className="space-y-4">
          {/* First Name */}
          <View>
            <Text className="text-gray-600">First name</Text>
            <TextInput
              placeholder="Apolade"
              className="w-full p-3 mt-1 border rounded-lg focus:border-black"
            />
          </View>

          {/* Last Name */}
          <View>
            <Text className="text-gray-600">Last name</Text>
            <TextInput
              placeholder="Nfetoniyo"
              className="w-full p-3 mt-1 border rounded-lg focus:border-black"
            />
          </View>

          {/* Email */}
          <View>
            <Text className="text-gray-600">Email address</Text>
            <TextInput
              placeholder="Apolade.nf@gmail.com"
              keyboardType="email-address"
              className="w-full p-3 mt-1 border rounded-lg focus:border-black"
            />
          </View>

          {/* Phone Number */}
          <View>
            <Text className="text-gray-600">Phone number</Text>
            <View className="flex-row items-center border rounded-lg overflow-hidden">
              <Text className="px-3 bg-gray-200 text-gray-600">🇳🇬</Text>
              <TextInput
                placeholder="0816424788"
                keyboardType="phone-pad"
                className="w-full p-3 focus:border-black"
              />
            </View>
          </View>

          {/* Save Changes Button */}
          <TouchableOpacity className="w-full mt-4 p-3 bg-black rounded-lg">
            <Text className="text-white text-center">Save changes</Text>
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
}
