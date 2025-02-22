// // import React, { useState } from "react";
// // import { View, Text, useWindowDimensions, StyleSheet, TouchableOpacity } from "react-native";
// // import Ionicons from "react-native-vector-icons/Ionicons";
// // import { SceneMap, TabView } from "react-native-tab-view";
// // import home from "../../components/home";
// // import profile from "../../components/profile";

// // import "../../global.css";
// // const ExploreTab = () => (
// //   <View style={styles.scene}>
// //     <Text style={styles.text}>Explore Screen</Text>
// //   </View>
// // );

// // const CreateTab = () => (
// //   <View style={styles.scene}>
// //     <Text style={styles.text}>Create Screen</Text>
// //   </View>
// // );
// // const TabsLayout = () => {
// //   const layout = useWindowDimensions();
// //   const [index, setIndex] = useState(0);

// //   const routes = [
// //     { key: "home", title: "Home", icon: "home-outline", activeIcon: "home" },
// //     { key: "explore", title: "Explore", icon: "compass-outline", activeIcon: "compass" },
// //     { key: "create", title: "Create", icon: "add-circle-outline", activeIcon: "add-circle" },
// //     { key: "profile", title: "Profile", icon: "person-outline", activeIcon: "person" },
// //   ];

// //   return (
// //     <View style={{ flex: 1 }}>
// //       <TabView
// //         navigationState={{ index, routes }}
// //         renderScene={SceneMap({
// //           home: home,
// //           explore: ExploreTab,
// //           create: CreateTab,
// //           profile: profile,
// //         })}
// //         onIndexChange={setIndex}
// //         initialLayout={{ width: layout.width }}
// //         renderTabBar={() => null} // Hide default TabBar
// //       />

// //       {/* Custom Bottom Tab Bar */}
// //       <View style={styles.tabContainer}>
// //         {routes.map((route, i) => (
// //           <TouchableOpacity key={route.key} style={styles.tabButton} onPress={() => setIndex(i)}>
// //             <Ionicons
// //               name={index === i ? route.activeIcon : route.icon}
// //               size={28}
// //               color={index === i ? "#008080" : "#777"}
// //             />
// //             <Text style={[styles.tabText, index === i && styles.activeTabText]}>{route.title}</Text>
// //           </TouchableOpacity>
// //         ))}
// //       </View>
// //     </View>
// //   );
// // };

// // // Styles
// // const styles = StyleSheet.create({
// //   scene: {
// //     flex: 1,
// //     justifyContent: "center",
// //     alignItems: "center",
// //     backgroundColor: "#f2f2f2",
// //   },
// //   text: {
// //     fontSize: 18,
// //     color: "#333",
// //   },
// //   tabContainer: {
// //     flexDirection: "row",
// //     position: "absolute",
// //     bottom: 10,
// //     left: 20,
// //     right: 20,
// //     borderRadius: 25,
// //     backgroundColor: "white",
// //     elevation: 5,
// //     height: 70,
// //     alignItems: "center",
// //     justifyContent: "space-around",
// //     shadowColor: "#000",
// //     shadowOpacity: 0.1,
// //     shadowOffset: { width: 0, height: 5 },
// //     shadowRadius: 5,
// //   },
// //   tabButton: {
// //     alignItems: "center",
// //   },
// //   tabText: {
// //     fontSize: 12,
// //     color: "#777",
// //     marginTop: 5,
// //   },
// //   activeTabText: {
// //     color: "#008080",
// //     fontWeight: "bold",
// //   },
// // });

// // export default TabsLayout;
// // import React, { useState } from "react";
// // import { View, Text, useWindowDimensions, StyleSheet, TouchableOpacity } from "react-native";
// // import Ionicons from "react-native-vector-icons/Ionicons";
// // import { SceneMap, TabView } from "react-native-tab-view";
// // import { useNavigation } from "@react-navigation/native";

// // import home from "../../components/home";
// // import profile from "../../components/profile";

// // import "../../global.css";

// // const ExploreTab = () => (
// //   <View style={styles.scene}>
// //     <Text style={styles.text}>Explore Screen</Text>
// //   </View>
// // );

// // const CreateTab = () => (
// //   <View style={styles.scene}>
// //     <Text style={styles.text}>Create Screen</Text>
// //   </View>
// // );

// // const TabsLayout = () => {
// //   const layout = useWindowDimensions();
// //   const navigation = useNavigation(); // Get navigation prop
// //   const [index, setIndex] = useState(0);

// //   const routes = [
// //     { key: "home", title: "Home", icon: "home-outline", activeIcon: "home" },
// //     { key: "explore", title: "Explore", icon: "compass-outline", activeIcon: "compass" },
// //     { key: "create", title: "Create", icon: "add-circle-outline", activeIcon: "add-circle" },
// //     { key: "profile", title: "Profile", icon: "person-outline", activeIcon: "person" },
// //   ];

// //   return (
// //     <View style={{ flex: 1 }}>
// //       {/* Top Header with Back Button */}
// //       <View style={styles.header}>
// //         {index !== 0 && (
// //           <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
// //             <Ionicons name="arrow-back" size={24} color="black" />
// //           </TouchableOpacity>
// //         )}
// //         <Text style={styles.headerText}>{routes[index].title}</Text>
// //       </View>

// //       <TabView
// //         navigationState={{ index, routes }}
// //         renderScene={SceneMap({
// //           home: home,
// //           explore: ExploreTab,
// //           create: CreateTab,
// //           profile: profile,
// //         })}
// //         onIndexChange={setIndex}
// //         initialLayout={{ width: layout.width }}
// //         renderTabBar={() => null} // Hide default TabBar
// //       />

// //       {/* Custom Bottom Tab Bar */}
// //       <View style={styles.tabContainer}>
// //         {routes.map((route, i) => (
// //           <TouchableOpacity key={route.key} style={styles.tabButton} onPress={() => setIndex(i)}>
// //             <Ionicons
// //               name={index === i ? route.activeIcon : route.icon}
// //               size={28}
// //               color={index === i ? "#008080" : "#777"}
// //             />
// //             <Text style={[styles.tabText, index === i && styles.activeTabText]}>{route.title}</Text>
// //           </TouchableOpacity>
// //         ))}
// //       </View>
// //     </View>
// //   );
// // };

// // // Styles
// // const styles = StyleSheet.create({
// //   scene: {
// //     flex: 1,
// //     justifyContent: "center",
// //     alignItems: "center",
// //     backgroundColor: "#f2f2f2",
// //   },
// //   text: {
// //     fontSize: 18,
// //     color: "#333",
// //   },
// //   header: {
// //     flexDirection: "row",
// //     alignItems: "center",
// //     padding: 15,
// //     backgroundColor: "white",
// //     elevation: 5,
// //     shadowColor: "#000",
// //     shadowOpacity: 0.1,
// //     shadowOffset: { width: 0, height: 5 },
// //     shadowRadius: 5,
// //   },
// //   backButton: {
// //     marginRight: 15,
// //   },
// //   headerText: {
// //     fontSize: 18,
// //     fontWeight: "bold",
// //   },
// //   tabContainer: {
// //     flexDirection: "row",
// //     position: "absolute",
// //     bottom: 10,
// //     left: 20,
// //     right: 20,
// //     borderRadius: 25,
// //     backgroundColor: "white",
// //     elevation: 5,
// //     height: 70,
// //     alignItems: "center",
// //     justifyContent: "space-around",
// //     shadowColor: "#000",
// //     shadowOpacity: 0.1,
// //     shadowOffset: { width: 0, height: 5 },
// //     shadowRadius: 5,
// //   },
// //   tabButton: {
// //     alignItems: "center",
// //   },
// //   tabText: {
// //     fontSize: 12,
// //     color: "#777",
// //     marginTop: 5,
// //   },
// //   activeTabText: {
// //     color: "#008080",
// //     fontWeight: "bold",
// //   },
// // });

// // export default TabsLayout;


// import React, { useState, useCallback, useMemo } from "react";
// import { View, Text, useWindowDimensions, StyleSheet, TouchableOpacity } from "react-native";
// import Ionicons from "react-native-vector-icons/Ionicons";
// import { SceneMap, TabView } from "react-native-tab-view";
// import { useNavigation } from "@react-navigation/native";

// import home from "./home";
// import profile from "./profile";
// import booking from "./booking";
// // import "../../global.css";

// // Separate components for performance optimization
// // const ExploreTab = React.memo(() => (
// //   <View style={styles.scene}>
// //     <Text style={styles.text}>Explore Screen</Text>
// //   </View>
// // ));

// const CreateTab = React.memo(() => (
//   <View style={styles.scene}>
//     <Text style={styles.text}>Create Screen</Text>
//   </View>
// ));

// const TabsLayout = () => {
//   const layout = useWindowDimensions();
//   const navigation = useNavigation();
//   const [index, setIndex] = useState(0);

//   const routes = useMemo(() => [
//     { key: "home", title: "Home", icon: "home-outline", activeIcon: "home" },
//     { key: "explore", title: "Explore", icon: "compass-outline", activeIcon: "compass" },
//     { key: "create", title: "Create", icon: "add-circle-outline", activeIcon: "add-circle" },
//     { key: "profile", title: "Profile", icon: "person-outline", activeIcon: "person" },
//   ], []);

//   const renderScene = useCallback(
//     SceneMap({
//       home: home,
//       explore: booking,
//       create: CreateTab,
//       profile: profile,
//     }),
//     []
//   );

//   return (
//     <View style={{ flex: 1 }}>
//       {/* Top Header */}
//       <View style={styles.header}>
//         {index !== 0 && (
//           <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
//             <Ionicons name="arrow-back" size={24} color="black" />
//           </TouchableOpacity>
//         )}
//         <Text style={styles.headerText}>{routes[index].title}</Text>
//       </View>

//       <TabView
//         navigationState={{ index, routes }}
//         renderScene={renderScene}
//         onIndexChange={setIndex}
//         initialLayout={{ width: layout.width }}
//         renderTabBar={() => null}
//         animationEnabled={false} // Faster switching
//         swipeEnabled={false} // Disable swipe gestures
//       />

//       {/* Optimized Bottom Tab Bar */}
//       <View style={styles.tabContainer}>
//         {routes.map((route, i) => (
//           <TouchableOpacity key={route.key} style={styles.tabButton} onPress={() => setIndex(i)}>
//             <Ionicons
//               name={index === i ? route.activeIcon : route.icon}
//               size={28}
//               color={index === i ? "#008080" : "#777"}
//             />
//             <Text style={[styles.tabText, index === i && styles.activeTabText]}>{route.title}</Text>
//           </TouchableOpacity>
//         ))}
//       </View>
//     </View>
//   );
// };

// // Styles
// const styles = StyleSheet.create({
//   scene: {
//     flex: 1,
//     justifyContent: "center",
//     alignItems: "center",
//     backgroundColor: "#f2f2f2",
//   },
//   text: {
//     fontSize: 18,
//     color: "#333",
//   },
//   header: {
//     flexDirection: "row",
//     alignItems: "center",
//     padding: 15,
//     backgroundColor: "white",
//     elevation: 5,
//     shadowColor: "#000",
//     shadowOpacity: 0.1,
//     shadowOffset: { width: 0, height: 5 },
//     shadowRadius: 5,
//   },
//   backButton: {
//     marginRight: 15,
//   },
//   headerText: {
//     fontSize: 18,
//     fontWeight: "bold",
//   },
//   tabContainer: {
//     flexDirection: "row",
//     position: "absolute",
//     bottom: 10,
//     left: 20,
//     right: 20,
//     borderRadius: 25,
//     backgroundColor: "white",
//     elevation: 5,
//     height: 70,
//     alignItems: "center",
//     justifyContent: "space-around",
//     shadowColor: "#000",
//     shadowOpacity: 0.1,
//     shadowOffset: { width: 0, height: 5 },
//     shadowRadius: 5,
//   },
//   tabButton: {
//     alignItems: "center",
//   },
//   tabText: {
//     fontSize: 12,
//     color: "#777",
//     marginTop: 5,
//   },
//   activeTabText: {
//     color: "#008080",
//     fontWeight: "bold",
//   },
// });

// export default TabsLayout;
import React, { useState, useCallback } from "react";
import { View, Text, useWindowDimensions, TouchableOpacity } from "react-native";
import Ionicons from "react-native-vector-icons/Ionicons";
import { SceneMap, TabView } from "react-native-tab-view";
import { useNavigation } from "@react-navigation/native";

import home from "./home";
import profile from "./profile";
import booking from "./booking";

const CreateTab = React.memo(() => (
  <View className="flex-1 justify-center items-center bg-gray-100">
    <Text className="text-lg text-gray-800">Create Screen</Text>
  </View>
));

const TabsLayout = () => {
  const layout = useWindowDimensions();
  const navigation = useNavigation();
  const [index, setIndex] = useState(0);

  const routes = [
    { key: "home", title: "Home", icon: "home-outline", activeIcon: "home" },
    { key: "booking", title: "Booking", icon: "book-outline", activeIcon: "book" },
    { key: "create", title: "Create", icon: "add-circle-outline", activeIcon: "add-circle" },
    { key: "profile", title: "Profile", icon: "person-outline", activeIcon: "person" },
  ];

  const renderScene = SceneMap({
    home: home,
    booking: booking,
    create: CreateTab,
    profile: profile,
  });

  const handleTabPress = useCallback((i) => {
    setIndex(i);
  }, []);

  return (
    <View className="flex-1">
      {/* Top Header with Back Button */}
      <View className="flex-row items-center p-4 bg-white shadow-md">
        {index !== 0 && (
          <TouchableOpacity onPress={() => navigation.goBack()} className="mr-4">
            <Ionicons name="arrow-back" size={24} color="black" />
          </TouchableOpacity>
        )}
        <Text className="text-lg font-bold">{routes[index].title}</Text>
      </View>

      <TabView
        navigationState={{ index, routes }}
        renderScene={renderScene}
        onIndexChange={setIndex}
        initialLayout={{ width: layout.width }}
        renderTabBar={() => null} // Hide default TabBar
        animationEnabled={false} // Faster switching
        swipeEnabled={false} // Disable swipe gestures
      />

      {/* Custom Bottom Tab Bar */}
      <View className="flex-row absolute bottom-3 left-5 right-5 bg-white rounded-2xl shadow-lg h-16 items-center justify-around">
        {routes.map((route, i) => (
          <TouchableOpacity key={route.key} className="items-center" onPress={() => handleTabPress(i)}>
            <Ionicons
              name={index === i ? route.activeIcon : route.icon}
              size={28}
              color={index === i ? "#008080" : "#777"}
            />
            <Text className={`text-xs mt-1 ${index === i ? "text-teal-600 font-bold" : "text-gray-500"}`}>
              {route.title}
            </Text>
          </TouchableOpacity>
        ))}
      </View>
    </View>
  );
};

export default TabsLayout;
