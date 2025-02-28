// import React, { useState, useRef } from 'react';
// import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
// import { TextInput, FAB } from 'react-native-paper'; // Import FAB from react-native-paper
// import { useForm, Controller } from 'react-hook-form';
// import * as yup from 'yup';
// import { yupResolver } from '@hookform/resolvers/yup';
// import { Picker } from "@react-native-picker/picker";

// // Define the validation schema
// const schema = yup.object().shape({
//   States_Name: yup.string().required('State Name is required'),
//   City_Name: yup.string().required('City Name is required'),
// });

// const screenHeight = Dimensions.get("window").height; // Get screen height

// const CityMaster = () => {
//   const [modalVisible, setModalVisible] = useState(false);
//   const slideAnim = useRef(new Animated.Value(500)).current; // Persist animation value
//   const startY = useRef(0); // Store touch start position

//   // Initialize with static values
//   const [branches, setBranches] = useState([
//     {
//       City_Name: "ABC Corp",
//       States_Name: "WB"
//     }
//   ]);

//   const statesList = [
//     { label: "Select State", value: "" }, // Default option
//     { label: "California", value: "california" },
//     { label: "Texas", value: "texas" },
//     { label: "Florida", value: "florida" },
//     { label: "New York", value: "new_york" },
//     { label: "Illinois", value: "illinois" },
//   ];


//   const openModal = () => {
//     slideAnim.setValue(screenHeight);
//     setModalVisible(true); // Set modal visible first
//     setTimeout(() => {
//       Animated.timing(slideAnim, {
//         toValue: 0,
//         duration: 300,
//         useNativeDriver: true,
//       }).start();
//     }, 10); // Small delay to prevent flicker
//   };

//   const closeModal = () => {
//     Animated.timing(slideAnim, {
//       toValue: screenHeight,
//       duration: 300,
//       useNativeDriver: true,
//     }).start(() => setModalVisible(false));
//   };

//   // PanResponder to detect swipe gestures
//   const panResponder = PanResponder.create({
//     onStartShouldSetPanResponder: () => true,
//     onPanResponderGrant: (_, gestureState) => {
//       startY.current = gestureState.y0; // Capture start position
//     },
//     onPanResponderRelease: (_, gestureState) => {
//       const endY = gestureState.moveY;
//       if (endY - startY.current > 100) {
//         // If swipe down distance is significant, close modal
//         closeModal();
//       }
//     },
//   });

//   const { control, handleSubmit, reset, setValue, formState: { errors } } = useForm({
//     resolver: yupResolver(schema),
//   });


//   const onSubmit = async (data) => {
//     const newBranch = { ...data };
//     setBranches([...branches, newBranch]);
//     Alert.alert('Form Submitted', JSON.stringify(newBranch, null, 2));
//     reset(); // Reset form fields after submission
//     closeModal(); // Close the modal after submission
//   };

//   const renderBranchItem = ({ item }) => (
//     <View className="bg-white p-4 mb-3 rounded-lg shadow-md border border-gray-200">
//       <Text className="text-black font-semibold text-lg">
//         <Text className="text-blue-600">{item.City_Name} - {item.States_Name}</Text>
//       </Text>
//     </View>
//   );

//   return (
//     <View style={{ flex: 1 }}>
//       <FlatList
//         data={branches}
//         renderItem={renderBranchItem}
//         keyExtractor={(item, index) => index.toString()}
//         contentContainerStyle={styles.listContainer}
//       />
//       <FAB
//         style={styles.fab}
//         icon="plus"
//         onPress={openModal}
//       />
//       <Modal transparent visible={modalVisible} animationType="none">
//         <View style={styles.modalContainer}>
//           <Animated.View
//             {...panResponder.panHandlers} // Attach gesture detection
//             style={[styles.modalContent, { transform: [{ translateY: slideAnim }] }]}
//           >
//             <ScrollView contentContainerStyle={{ flexGrow: 1, paddingBottom: 80, minHeight: screenHeight * 0.6 }} showsVerticalScrollIndicator={false} keyboardShouldPersistTaps="handled">
//               <View className="gap-2">
//                 <Controller
//                   control={control}
//                   name="States_Name"
//                   render={({ field: { onChange, value } }) => (
//                     <View>
//                       <Picker selectedValue={value} onValueChange={onChange}>
//                         {statesList.map((state, index) => (
//                           <Picker.Item key={index} label={state.label} value={state.value} />
//                         ))}
//                       </Picker>
//                       {errors.States_Name && <Text style={styles.errorText}>{errors.States_Name.message}</Text>}
//                     </View>
//                   )}
//                 />


//                 <Controller
//                   control={control}
//                   name="City_Name"
//                   render={({ field: { onChange, value } }) => (
//                     <View>
//                       <TextInput
//                         label="City Name"
//                         mode="outlined"
//                         value={value}
//                         onChangeText={onChange}
//                         style={stylesx.input}
//                       />
//                       {errors.City_Name && <Text style={styles.errorText}>{errors.City_Name.message}</Text>}
//                     </View>
//                   )}
//                 />

//                 <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)}>
//                   <Text style={styles.buttonText}>ADD</Text>
//                 </TouchableOpacity>
//               </View>
//             </ScrollView>
//           </Animated.View>
//         </View>
//       </Modal>
//     </View>
//   );
// };

// // Styles
// const styles = StyleSheet.create({
//   input: {
//     flex: 1,
//     borderWidth: 1,
//     borderColor: '#ccc',
//     padding: 10,
//     margin: 5,
//     borderRadius: 5,
//     backgroundColor: 'white',
//   },
//   button: {
//     backgroundColor: '#009688',
//     padding: 15,
//     borderRadius: 5,
//     marginTop: 10,
//     alignItems: 'center',
//   },
//   buttonText: {
//     color: 'white',
//     fontWeight: 'bold',
//   },
//   errorText: {
//     color: 'red',
//     fontSize: 12,
//     marginTop: 5,
//   },
//   logoText: {
//     marginTop: 5,
//     fontSize: 12,
//     color: 'green',
//   },
//   fab: {
//     position: 'absolute',
//     margin: 16,
//     right: 4,
//     bottom: 48,
//   },
//   modalContent: {
//     height: screenHeight * 0.5,
//     backgroundColor: "white",
//     borderTopLeftRadius: 20,
//     borderTopRightRadius: 20,
//     padding: 20,
//     width: "100%",
//   },
//   modalContainer: {
//     flex: 1,
//     backgroundColor: "rgba(0, 0, 0, 0.5)",
//     justifyContent: "flex-end",
//   },
//   listContainer: {
//     padding: 16,
//   },
//   branchItem: {
//     backgroundColor: '#ffffff',
//     padding: 15,
//     marginVertical: 10,
//     marginHorizontal: 15,
//     borderRadius: 10,
//     shadowColor: '#000',
//     shadowOffset: { width: 0, height: 2 },
//     shadowOpacity: 0.1,
//     shadowRadius: 4,
//     elevation: 3, // Android shadow
//     borderWidth: 1,
//     borderColor: '#ddd',
//   },
//   branchTitle: {
//     fontSize: 18,
//     fontWeight: 'bold',
//     marginBottom: 5,
//     color: '#333',
//   },
//   branchText: {
//     fontSize: 14,
//     color: '#555',
//     marginBottom: 2,
//   },


//   // dateText: {
//   //     fontSize: 14,
//   //     marginBottom: 10,
//   // },
// });


// const stylesin = StyleSheet.create({
//   container: {
//     flex: 1,
//     flexDirection: 'row',
//     justifyContent: 'space-between',
//     alignItems: 'center',
//   },
//   inputContainer: {
//     flex: 1,
//     minWidth: "45%", // Ensures proper spacing
//     maxWidth: "50%",
//   },
//   input: {
//     borderRadius: 8,
//     height: 40,
//     fontSize: 12,
//   },
//   errorInput: {
//     borderColor: "red", // Changes only the border color
//     borderBlockColor: 1,
//   },
//   errorText: {
//     color: 'red',
//     fontSize: 10,
//     textAlign: "left",
//   },
// });


// const stylesx = StyleSheet.create({
//   input: {
//     paddingVertical: 0,
//     paddingHorizontal: 0,
//     margin: 0,
//     fontSize: 10,
//     height: 40,
//   },
//   inputContent: {
//     paddingVertical: 0,
//     paddingHorizontal: 0,
//   },
// });

// export default CityMaster;




import React, { useState, useRef } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { Picker } from "@react-native-picker/picker";
import { MaterialIcons } from '@expo/vector-icons'; // Import icons

// Define the validation schema
const schema = yup.object().shape({
  States_Name: yup.string().required('State Name is required'),
  City_Name: yup.string().required('City Name is required'),
});

const screenHeight = Dimensions.get("window").height; // Get screen height

const CityMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const [selectedBranch, setSelectedBranch] = useState(null); // Track selected branch for editing
  const slideAnim = useRef(new Animated.Value(screenHeight)).current; // Persist animation value
  const startY = useRef(0); // Store touch start position

  // Initialize with static values
  const [branches, setBranches] = useState([
    {
      City_Name: "ABC Corp",
      States_Name: "WB"
    }
  ]);

  const statesList = [
    { label: "Select", value: "" }, // Default option
    { label: "California", value: "california" },
    { label: "Texas", value: "texas" },
    { label: "Florida", value: "florida" },
    { label: "New York", value: "new_york" },
    { label: "Illinois", value: "illinois" },
  ];

  const openModal = (branch = null) => {
    slideAnim.setValue(screenHeight);
    setModalVisible(true);
    if (branch) {
      setSelectedBranch(branch);
      setValue("States_Name", branch.States_Name);
      setValue("City_Name", branch.City_Name);
    } else {
      reset();
      setSelectedBranch(null);
    }
    setTimeout(() => {
      Animated.timing(slideAnim, {
        toValue: 0,
        duration: 300,
        useNativeDriver: true,
      }).start();
    }, 10); // Small delay to prevent flicker
  };

  const closeModal = () => {
    Animated.timing(slideAnim, {
      toValue: screenHeight,
      duration: 300,
      useNativeDriver: true,
    }).start(() => setModalVisible(false));
  };

  // PanResponder to detect swipe gestures
  const panResponder = PanResponder.create({
    onStartShouldSetPanResponder: () => true,
    onPanResponderGrant: (_, gestureState) => {
      startY.current = gestureState.y0; // Capture start position
    },
    onPanResponderRelease: (_, gestureState) => {
      const endY = gestureState.moveY;
      if (endY - startY.current > 100) {
        // If swipe down distance is significant, close modal
        closeModal();
      }
    },
  });

  const { control, handleSubmit, reset, setValue, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const onSubmit = async (data) => {
    if (selectedBranch) {
      // Update existing branch
      const updatedBranches = branches.map(branch => 
        branch === selectedBranch ? { ...branch, ...data } : branch
      );
      setBranches(updatedBranches);
      Alert.alert('Updated', 'Branch updated successfully');
    } else {
      // Add new branch
      const newBranch = { ...data };
      setBranches([...branches, newBranch]);
      Alert.alert('Added', 'Branch added successfully');
    }
    reset(); // Reset form fields after submission
    closeModal(); // Close the modal after submission
  };

  const deleteBranch = (branch) => {
    Alert.alert(
      'Delete Branch',
      'Are you sure you want to delete this branch?',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'OK', onPress: () => {
          setBranches(branches.filter(item => item !== branch));
          Alert.alert('Deleted', 'Branch deleted successfully');
        }},
      ]
    );
  };

  const renderBranchItem = ({ item }) => (
    <TouchableOpacity onPress={() => setSelectedBranch(selectedBranch?.id === item.id ? null : item)}>
      <View style={styles.branchItem}>
        <Text style={styles.branchText}>{item.City_Name} - {item.States_Name}</Text>
        {selectedBranch?.id === item.id && (
          <View style={styles.iconContainer}>
            <TouchableOpacity onPress={() => openModal(item)}>
              <MaterialIcons name="edit" size={24} color="blue" />
            </TouchableOpacity>
            <TouchableOpacity onPress={() => deleteBranch(item)}>
              <MaterialIcons name="delete" size={24} color="red" />
            </TouchableOpacity>
          </View>
        )}
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={{ flex: 1 }}>
      <FlatList
        data={branches}
        renderItem={renderBranchItem}
        keyExtractor={(item, index) => index.toString()}
        contentContainerStyle={styles.listContainer}
      />
      <FAB
        style={styles.fab}
        icon="plus"
        onPress={() => openModal()}
      />
      <Modal transparent visible={modalVisible} animationType="none">
        <View style={styles.modalContainer}>
          <Animated.View
            {...panResponder.panHandlers} // Attach gesture detection
            style={[styles.modalContent, { transform: [{ translateY: slideAnim }] }]}
          >
            <ScrollView contentContainerStyle={{ flexGrow: 1, paddingBottom: 80, minHeight: screenHeight * 0.6 }} showsVerticalScrollIndicator={false} keyboardShouldPersistTaps="handled">
              <View style={{ gap: 2 }}>
                <Controller
                  control={control}
                  name="States_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <Picker selectedValue={value} onValueChange={onChange}>
                        {statesList.map((state, index) => (
                          <Picker.Item key={index} label={state.label} value={state.value} />
                        ))}
                      </Picker>
                      {errors.States_Name && <Text style={styles.errorText}>{errors.States_Name.message}</Text>}
                    </View>
                  )}
                />
                <Controller
                  control={control}
                  name="City_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="City Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.City_Name && <Text style={styles.errorText}>{errors.City_Name.message}</Text>}
                    </View>
                  )}
                />
                <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)}>
                  <Text style={styles.buttonText}>{selectedBranch ? "Update" : "Add"}</Text>
                </TouchableOpacity>
              </View>
            </ScrollView>
          </Animated.View>
        </View>
      </Modal>
    </View>
  );
};

// Styles
const styles = StyleSheet.create({
  input: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 10,
    margin: 5,
    borderRadius: 5,
    backgroundColor: 'white',
  },
  button: {
    backgroundColor: '#009688',
    padding: 15,
    borderRadius: 5,
    marginTop: 10,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
  },
  errorText: {
    color: 'red',
    fontSize: 12,
    marginTop: 5,
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 4,
    bottom: 48,
  },
  modalContent: {
    height: screenHeight * 0.5,
    backgroundColor: "white",
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 20,
    width: "100%",
  },
  modalContainer: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  listContainer: {
    padding: 16,
  },
  branchItem: {
    backgroundColor: '#ffffff',
    padding: 15,
    marginVertical: 10,
    marginHorizontal: 15,
    borderRadius: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  branchText: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  iconContainer: {
    flexDirection: 'row',
    gap: 10,
  },
});

export default CityMaster;






