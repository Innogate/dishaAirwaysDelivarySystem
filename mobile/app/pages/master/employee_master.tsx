import React, { useState, useRef, useEffect } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB, Button } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import * as ImagePicker from 'expo-image-picker';
import { Picker } from '@react-native-picker/picker'; // Import Picker for gender selection
import styles from '@/app/components/GlobalStyle';
import globalStorage from '@/app/components/GlobalStorage';
import Constants from "expo-constants";
const API_BASE_URL = Constants.expoConfig?.extra?.API_BASE_URL;
// Define the validation schema
const schema = yup.object().shape({
  Employee_Name: yup.string(),
  Employee_Id: yup.string(),
  Employee_Address: yup.string().required('Employee Address is required'),
  Employee_phoneNumber: yup.string()
    .required('Employee Phone Number is required')
    .matches(/^[0-9]{10}$/, 'Invalid phone number'),
  Employee_AadharNo: yup.string()
    .required('Employee Aadhar is required')
    .matches(/^[0-9]{12}$/, 'Invalid Aadhar number'),
  Join_Date: yup.string().required('Join Date is required').matches(/^\d{4}-\d{2}-\d{2}$/, 'Date must be in YYYY-MM-DD format'),
  Date_of_Birth: yup.string().required('Date of Birth is required').matches(/^\d{4}-\d{2}-\d{2}$/, 'Date must be in YYYY-MM-DD format'),
  Gender: yup.string().required('Gender is required'),
});

const screenHeight = Dimensions.get("window").height;

const EmployeeMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(500)).current;
  const startY = useRef(0);

  const [Employee, setEmployee] = useState('');
  const [User, setUser] = useState([]);



  const [token, setToken] = useState(null);
  const fetchToken = async () => {
    try {
      const storedToken = await globalStorage.getValue("token");
      if (storedToken) {
        setToken(storedToken); // State update is asynchronous
      } else {
        Alert.alert("Error", "Authentication token is missing.");
      }
    } catch (error) {
      Alert.alert("Error", "An error occurred while fetching the token.");
    }
  };


  const handleEmployeeSelect = (selectedId) => {
    const employee = User.find(user => user.id === selectedId);
    if (employee) {
      setValue("Employee_Id", employee.id);
      setValue("Employee_Address", employee.Employee_Address);
      setValue("Employee_phoneNumber", employee.Employee_phoneNumber);
      setValue("Date_of_Birth", employee.Employee_birth_date);
      setValue("Gender", employee.Employee_gender);
    }
  };


  const openModal = () => {
    slideAnim.setValue(screenHeight);
    setModalVisible(true);
    setTimeout(() => {
      Animated.timing(slideAnim, {
        toValue: 0,
        duration: 300,
        useNativeDriver: true,
      }).start();
    }, 10);
  };

  const closeModal = () => {
    Animated.timing(slideAnim, {
      toValue: screenHeight,
      duration: 300,
      useNativeDriver: true,
    }).start(() => setModalVisible(false));
  };

  const panResponder = PanResponder.create({
    onStartShouldSetPanResponder: () => true,
    onPanResponderGrant: (_, gestureState) => {
      startY.current = gestureState.y0;
    },
    onPanResponderRelease: (_, gestureState) => {
      const endY = gestureState.moveY;
      if (endY - startY.current > 100) {
        closeModal();
      }
    },
  });

  const { control, handleSubmit, setValue, reset, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const getAllEmploy = async () => {
    if (token) {
      const url = API_BASE_URL + "/master/employees";
      const header = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`
      };
      const body = JSON.stringify({
        from: 0,
      });

      try {
        const res = await fetch(url, {
          method: "POST",
          headers: header,
          body: body,
        });

        const resJson = await res.json();
        if (res.status === 200) {
          // Extract 'id' and 'name' from the 'body' array
          const formattedEmployee = resJson.body.map((Employee) => ({
            id: Employee.id,
            user_id: Employee.user_id,
            first_name: Employee.first_name,
            last_name: Employee.last_name,
            address: Employee.address,
            aadhar_no: Employee.aadhar_no,
            joining_date: Employee.joining_date,
          }));
          setEmployee(formattedEmployee);
        } else {
          Alert.alert("Error", resJson.message || "Failed to fetch states.");
        }
      } catch (error) {
        Alert.alert("Error", "Server Error");
        console.error("Fetch error:", error);
      }

    };
  }

  // get All user
  const getAllUser = async () => {
    if (token) {
      const url = API_BASE_URL + "/master/users";
      const header = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`
      };
      const body = JSON.stringify({
        from: 0,
      });
      try {
        const res = await fetch(url, {
          method: "POST",
          headers: header,
          body: body,
        });

        const resJson = await res.json();
        console.log("Response JSON:", resJson);

        if (res.status === 200) {
          // Extract 'id' and 'name' from the 'body' array
          const formattedStates = resJson.body.map((user) => ({
            id: user.id,
            Employee_FName: user.first_name,
            Employee_LName: user.last_name,
            Employee_birth_date: user.birth_date,
            Employee_phoneNumber: user.mobile,
            Employee_Address: user.address,
            Employee_gender: user.gender
          }));
          setUser(formattedStates);
        } else {
          Alert.alert("Error", resJson.message || "Failed to fetch states.");
        }
      } catch (error) {
        Alert.alert("Error", "Server Error");
        console.error("Fetch error:", error);
      }
    }
  };


  const onSubmit = async (data) => {
    console.log(data);
    if (data) {
      if (token) {
        const url = `${API_BASE_URL}/master/employees/new`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`
        };
        const body = JSON.stringify({
          user_id: data.Employee_Id,
          address: data.Employee_Address,
          adhara_no: data.Employee_AadharNo,
          joining_date: data.Join_Date,
          branch_id: "1",
          type: "2"
        });
        console.log("body",body);
        try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          console.log(resJson);
          if (res.status === 200) {
            Alert.alert("Success", resJson.message);
            closeModal(); // Close the modal after successful creation
            reset(); // Reset the form state
          } else {
            Alert.alert("Error", resJson.message || "Failed to fetch states.");
          }
        } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
        }
      }
    } else {
      Alert.alert('Error', 'Form validation failed');
    }
    closeModal();
  };

  useEffect(() => {
    fetchToken();
    if (token) {
      getAllEmploy();
      getAllUser();
    }
  }, [token]);


  const handleLogoUpload = async () => {
    const permissionResult = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (permissionResult.granted === false) {
      alert("Permission to access camera roll is required!");
      return;
    }

    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [4, 3],
      quality: 1,
    });

    if (!result.canceled) {
      setValue('logo', result.uri);
    }
  };

  const renderBranchItem = ({ item }) => (
    <View style={styles.branchItem}>
      <Text style={styles.branchText}> Employee Name: {item.first_name} {item.last_name}</Text>
      <Text style={styles.branchText}>Address: {item.address}</Text>
      {/* <Text style={styles.branchText}>Phone: {item.Employee_phoneNumber}</Text> */}
      <Text style={styles.branchText}>Aadhar: {item.aadhar_no}</Text>
      <Text style={styles.branchText}>Join Date: {item.joining_date}</Text>
      {/* <Text style={styles.branchText}>Date of Birth: {item.Date_of_Birth}</Text> */}
      {/* <Text style={styles.branchText}>Gender: {item.Gender}</Text> */}
    </View>
  );

  return (
    <View style={{ flex: 1 }}>
      <FlatList
        data={Employee}
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
            {...panResponder.panHandlers}
            style={[styles.modalContent, { transform: [{ translateY: slideAnim }] }]}
          >
            <ScrollView contentContainerStyle={{ flexGrow: 1, paddingBottom: 80, minHeight: screenHeight * 0.6 }} showsVerticalScrollIndicator={false} keyboardShouldPersistTaps="handled">
              <View className="gap-2">
                {/* <Controller
                  control={control}
                  name="Employee_Name"
                  render={({ field: { value } }) => (
                    <View style={styles.pickerWrapper}>
                      <Picker
                        selectedValue={value}
                        onValueChange={handleEmployeeSelect}
                        style={styles.pickerWrapper}
                      >
                        <Picker.Item label="Select an Employee" value="" />
                        {User.map((user) => (
                          <Picker.Item key={user.id} label={user.Employee_FName + " " + user.Employee_LName} value={user.id} />
                        ))}
                      </Picker>
                      {errors.Employee_Name && <Text style={styles.errorText}>{errors.Employee_Name.message}</Text>}

                    </View>
                  )}
                /> */}

                <View className="gap-2">
                  <Controller
                    control={control}
                    name="Employee_Id" // Store the selected Employee ID
                    render={({ field: { value } }) => (
                      <View style={styles.pickerWrapper}>
                        <Picker
                          selectedValue={value}
                          onValueChange={handleEmployeeSelect}
                          style={styles.pickerWrapper}
                        >
                          <Picker.Item label="Select an Employee" value="" />
                          {User.map((user) => (
                            <Picker.Item
                              key={user.id}
                              label={`${user.Employee_FName} ${user.Employee_LName}`}
                              value={user.id} // Store ID as value
                            />
                          ))}
                        </Picker>
                        {errors.Employee_Id && <Text style={styles.errorText}>{errors.Employee_Id.message}</Text>}
                      </View>
                    )}
                  />
                </View>


                <Controller
                  control={control}
                  name="Employee_Address"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Employee Address"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Employee_Address && <Text style={styles.errorText}>{errors.Employee_Address.message}</Text>}
                    </View>
                  )}
                />

                <View style={styles.container} className="gap-2">
                  <Controller
                    control={control}
                    name="Employee_phoneNumber"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Employee Phone Number"
                          mode='outlined'
                          keyboardType="numeric"
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Employee_phoneNumber && <Text style={styles.errorText}>{errors.Employee_phoneNumber.message}</Text>}
                      </View>
                    )}
                  />

                  <Controller
                    control={control}
                    name="Employee_AadharNo"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Employee Aadhar No"
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Employee_AadharNo && <Text style={styles.errorText}>{errors.Employee_AadharNo.message}</Text>}
                      </View>
                    )}
                  />
                </View>

                {/* Join Date Input */}
                <View style={styles.container} className="gap-2">
                  <Controller
                    control={control}
                    name="Join_Date"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                          label="Join Date (YYYY-MM-DD)"
                        />
                        {errors.Join_Date && <Text style={styles.errorText}>{errors.Join_Date.message}</Text>}
                      </View>
                    )}
                  />

                  {/* Date of Birth Input */}
                  <Controller
                    control={control}
                    name="Date_of_Birth"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                          label="Date of Birth (YYYY-MM-DD)"
                        />
                        {errors.Date_of_Birth && <Text style={styles.errorText}>{errors.Date_of_Birth.message}</Text>}
                      </View>
                    )}
                  />
                </View>

                {/* Gender Selection */}
                <Controller
                  control={control}
                  name="Gender"
                  render={({ field: { onChange, value } }) => (
                    <View style={styles.pickerWrapper}>
                      <Picker
                        selectedValue={value}
                        onValueChange={onChange}
                        style={styles.input}
                      >
                        <Picker.Item label="Select Gender" value="" />
                        <Picker.Item label="Male" value="Male" />
                        <Picker.Item label="Female" value="Female" />
                        <Picker.Item label="Other" value="Other" />
                      </Picker>
                      {errors.Gender && <Text style={styles.errorText}>{errors.Gender.message}</Text>}
                    </View>
                  )}
                />

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

export default EmployeeMaster;