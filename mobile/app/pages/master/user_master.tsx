import React, { useState, useRef } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB } from 'react-native-paper'; // Import FAB from react-native-paper
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import * as ImagePicker from 'expo-image-picker'; // Import expo-image-picker

// Define the validation schema
const schema = yup.object().shape({
  Employee_Name: yup.string().required('Employee Name is required'),
  Employee_Address: yup.string().required('Employee Address is required'),
  Employee_phoneNumber: yup.string()
  .required('Employee Phone Number is required')
  .matches(/^[0-9]{10}$/, 'Invalid phone number'),
  Employee_AadharNo: yup.string()
    .required('Employee Aadhar is required')
    .matches(/^[0-9]{12}$/, 'Invalid Aadhar number'),
});

const screenHeight = Dimensions.get("window").height; // Get screen height

const EmployeeMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(500)).current; // Persist animation value
  const startY = useRef(0); // Store touch start position

  // Initialize with static values
  const [branches, setBranches] = useState([
    {
      Company_Name: "ABC Corp",
      Company_Address: "123 Main St",
      Company_City: "New York",
      Company_Pincode: "10001",
      phoneNumber: "1234567890",
      Company_Email: "contact@abccorp.com",
      Company_GST: "GST123456",
      Company_CIN: "CIN123456",
      Company_Udyam: "Udyam123456",
      logo: "https://example.com/logo1.png"
    },
    {
      Company_Name: "XYZ Ltd",
      Company_Address: "456 Elm St",
      Company_City: "Los Angeles",
      Company_Pincode: "90001",
      phoneNumber: "0987654321",
      Company_Email: "info@xyzltd.com",
      Company_GST: "GST654321",
      Company_CIN: "CIN654321",
      Company_Udyam: "Udyam654321",
      logo: "https://example.com/logo2.png"
    },
    {
      Company_Name: "XYZ Ltd",
      Company_Address: "456 Elm St",
      Company_City: "Los Angeles",
      Company_Pincode: "90001",
      phoneNumber: "0987654321",
      Company_Email: "info@xyzltd.com",
      Company_GST: "GST654321",
      Company_CIN: "CIN654321",
      Company_Udyam: "Udyam654321",
      logo: "https://example.com/logo2.png"
    }
  ]);

  const openModal = () => {
    slideAnim.setValue(screenHeight);
    setModalVisible(true); // Set modal visible first
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

  const { control, handleSubmit, setValue, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const [logoUri, setLogoUri] = useState(null); // State to hold the logo URI

  const onSubmit = async (data) => {
    // If no errors, proceed with form submission
    const newBranch = { ...data, logo: logoUri };
    setBranches([...branches, newBranch]); // Add new branch to the list
    Alert.alert('Form Submitted', JSON.stringify(newBranch, null, 2));
    closeModal(); // Close the modal after submission
  };

  const handleLogoUpload = async () => {
    // Request permission to access the media library
    const permissionResult = await ImagePicker.requestMediaLibraryPermissionsAsync();

    if (permissionResult.granted === false) {
      alert("Permission to access camera roll is required!");
      return;
    }

    // Launch the image picker
    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [4, 3],
      quality: 1,
    });

    if (!result.canceled) {
      setLogoUri(result.uri); // Set the logo URI
      setValue('logo', result); // Set the logo in form state
    }
  };

  const renderBranchItem = ({ item }) => (
    // <View style={styles.branchItem}>
    <View className="bg-white p-4 mb-3 rounded-lg shadow-md border border-gray-200">
      <Text className="text-black font-semibold text-lg">
        Order #: <Text className="text-blue-600">{item.Company_Name}</Text>
      </Text>
      <Text className="text-gray-500">{item.Company_Name}</Text>

      <View className="flex-row justify-between items-center mt-2">
        <View className="bg-gray-200 px-3 py-1 rounded-full">
          <Text className="text-gray-700">{item.Company_Name}</Text>
        </View>
        <Text className="text-lg font-bold">{item.Company_Name}</Text>
        {/* <TouchableOpacity
                    className={`px-4 py-1 rounded-full ${order.status === "Shipped" ? "bg-purple-100 border border-purple-600" : "bg-orange-100 border border-orange-500"
                        }`}
                >
                    <Text className={order.status === "Shipped" ? "text-purple-600" : "text-orange-600"}>{order.status}</Text>
                </TouchableOpacity> */}
      </View>
    </View>
    // {/* </View> */}
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
        onPress={openModal}
      />
      <Modal transparent visible={modalVisible} animationType="none">
        <View style={styles.modalContainer}>
          <Animated.View
            {...panResponder.panHandlers} // Attach gesture detection
            style={[styles.modalContent, { transform: [{ translateY: slideAnim }] }]}
          >
            <ScrollView contentContainerStyle={{ flexGrow: 1, paddingBottom: 80, minHeight: screenHeight * 0.6 }} showsVerticalScrollIndicator={false} keyboardShouldPersistTaps="handled">
              <Text style={styles.dateText}>Date: {new Date().toLocaleDateString()}</Text>

              <View className="gap-2">
                <Controller
                  control={control}
                  name="First_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="First Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={stylesx.input}
                      />
                      {errors.First_Name && <Text style={styles.errorText}>{errors.First_Name.message}</Text>}
                    </View>
                  )}
                />

                <Controller
                  control={control}
                  name="List_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="List Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={stylesx.input}
                      />
                      {errors.List_Name && <Text style={styles.errorText}>{errors.List_Name.message}</Text>}
                    </View>
                  )}
                />

                {/* Company Phone Number */}
                <Controller
                  control={control}
                  name="User_phoneNumber"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="User Phone Number"
                        mode='outlined'
                        keyboardType="numeric"
                        value={value}
                        onChangeText={onChange}
                        style={stylesx.input}
                      />
                      {errors.Employee_phoneNumber && <Text style={styles.errorText}>{errors. Employee_phoneNumber.message}</Text>}
                    </View>
                  )}
                />


                <Controller
                  control={control}
                  name="Employee_AadharNo"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Employ Aadhar No"
                        mode='outlined'
                        value={value}
                        onChangeText={onChange}
                        style={stylesx.input}
                      />
                      {errors.Employee_AadharNo && <Text style={styles.errorText}>{errors.Employee_AadharNo.message}</Text>}
                    </View>
                  )}
                />

                

                {/* Submit Button */}
                <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)}>
                  <Text style={styles.buttonText}>SUBMIT</Text>
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
  logoText: {
    marginTop: 5,
    fontSize: 12,
    color: 'green',
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 4,
    bottom: 48,
  },
  modalContent: {
    height: screenHeight * 0.6,
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
    elevation: 3, // Android shadow
    borderWidth: 1,
    borderColor: '#ddd',
  },
  branchTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 5,
    color: '#333',
  },
  branchText: {
    fontSize: 14,
    color: '#555',
    marginBottom: 2,
  },


  // dateText: {
  //     fontSize: 14,
  //     marginBottom: 10,
  // },
});


const stylesin = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  inputContainer: {
    flex: 1,
    minWidth: "45%", // Ensures proper spacing
    maxWidth: "50%",
  },
  input: {
    borderRadius: 8,
    height: 40,
    fontSize: 12,
  },
  errorInput: {
    borderColor: "red", // Changes only the border color
    borderBlockColor: 1,
  },
  errorText: {
    color: 'red',
    fontSize: 10,
    textAlign: "left",
  },
});


const stylesx = StyleSheet.create({
  input: {
    paddingVertical: 0,
    paddingHorizontal: 0,
    margin: 0,
    fontSize: 10,
    height: 40,
  },
  inputContent: {
    paddingVertical: 0,
    paddingHorizontal: 0,
  },
});

export default EmployeeMaster;











