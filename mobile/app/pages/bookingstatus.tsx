// import React from "react";
// import { View, Text, FlatList } from "react-native";
// import { TouchableOpacity } from "react-native";
// import { SafeAreaView } from "react-native-safe-area-context";

// const orders = [
//     { id: "1", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "2", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "3", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Accepted" },
//     { id: "4", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "5", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "6", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "7", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "8", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "9", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "10", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "11", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
//     { id: "12", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },

// ];

// const OrderItem = ({ order }) => {
//     return (
//         <View className="bg-white p-4 mb-3 rounded-lg shadow-md border border-gray-200">
//             <Text className="text-black font-semibold text-lg">
//                 Order #: <Text className="text-blue-600">{order.orderNo}</Text>
//             </Text>
//             <Text className="text-gray-500">{order.date}</Text>

//             <View className="flex-row justify-between items-center mt-2">
//                 <View className="bg-gray-200 px-3 py-1 rounded-full">
//                     <Text className="text-gray-700">{order.weight}</Text>
//                 </View>
//                 <Text className="text-lg font-bold">{order.price}</Text>
//                 <TouchableOpacity
//                     className={`px-4 py-1 rounded-full ${order.status === "Shipped" ? "bg-purple-100 border border-purple-600" : "bg-orange-100 border border-orange-500"
//                         }`}
//                 >
//                     <Text className={order.status === "Shipped" ? "text-purple-600" : "text-orange-600"}>{order.status}</Text>
//                 </TouchableOpacity>
//             </View>
//         </View>
//     );
// };

// const RecentOrdersScreen = () => {
//     return (
//         <SafeAreaView className="flex-1 bg-purple-600 p-4">
//             {/* <Text className="text-white text-2xl font-bold">Recent Orders</Text> */}
//             {/* <Text className="text-white text-sm mb-4">Below are your most recent orders</Text> */}

//             <FlatList
//                 data={orders}
//                 keyExtractor={(item) => item.id}
//                 renderItem={({ item }) => <OrderItem order={item} />}
//                 showsVerticalScrollIndicator={false}
//             />
//         </SafeAreaView>
//     );
// };

// export default RecentOrdersScreen;





import React from "react";
import { View, Text, FlatList } from "react-native";
import { TouchableOpacity } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";

const orders = [
    { id: "1", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
    { id: "2", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
    { id: "3", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Accepted" },
    { id: "4", orderNo: "429242424", date: "Mon. July 3rd", weight: "2.5 lbs", price: "$1.50", status: "Shipped" },
];

const OrderItem = ({ order }) => {
    return (
        <View className="bg-white p-4 mb-3 rounded-lg shadow-md border border-gray-200">
            <Text className="text-black font-semibold text-lg">
                Order #: <Text className="text-blue-600">{order.orderNo}</Text>
            </Text>
            <Text className="text-gray-500">{order.date}</Text>

            <View className="flex-row justify-between items-center mt-2">
                <View className="bg-gray-200 px-3 py-1 rounded-full">
                    <Text className="text-gray-700">{order.weight}</Text>
                </View>
                <Text className="text-lg font-bold">{order.price}</Text>
                <TouchableOpacity
                    className={`px-4 py-1 rounded-full ${order.status === "Shipped" ? "bg-purple-100 border border-purple-600" : "bg-orange-100 border border-orange-500"
                        }`}
                >
                    <Text className={order.status === "Shipped" ? "text-purple-600" : "text-orange-600"}>{order.status}</Text>
                </TouchableOpacity>
            </View>
        </View>
    );
};

const RecentOrdersScreen = () => {
    const handleAddOrder = () => {
        console.log("Add Order button clicked!");
    };

    return (
        <SafeAreaView className="flex-1 bg-purple-600 p-4">
            <FlatList
                data={orders}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => <OrderItem order={item} />}
                showsVerticalScrollIndicator={false}
            />

            {/* Floating Add Button */}
            <TouchableOpacity
                className="absolute bottom-6 right-6 bg-blue-500 p-4 rounded-full shadow-lg"
                onPress={handleAddOrder}
            >
                <Ionicons name="add" size={28} color="white" />
            </TouchableOpacity>
        </SafeAreaView>
    );
};

export default RecentOrdersScreen;
