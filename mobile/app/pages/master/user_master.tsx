import React, { useState, useRef, useEffect } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { API_BASE_URL } from '@/constants/api.url';
import styles from '@/app/components/GlobalStyle';
import { Picker } from '@react-native-picker/picker';
import globalStorage from '@/app/components/GlobalStorage';
const schema = yup.object().shape({
  Employee_FName: yup.string().required('Employee First Name is required'),
  Employee_LName: yup.string().required('Employee Last Name is required'),
  Employee_Address: yup.string().required('Employee Address is required'),
  Employee_phoneNumber: yup.string()
    .required('Employee Phone Number is required')
    .matches(/^[0-9]{10}$/, 'Invalid phone number'),
  password: yup.string()
    .required('Password is required')
    .min(6, 'Password must be at least 6 characters'),
  gender: yup.string().required('Gender is required'),
  birth_date: yup.string().required('Birth Date is required').matches(/^\d{4}-\d{2}-\d{2}$/, 'Date must be in YYYY-MM-DD format'),
  email: yup.string().email('Invalid email format').required('Email is required'),
});

const screenHeight = Dimensions.get("window").height;

const EmployeeMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(500)).current;
  const startY = useRef(0);
  const [User, setUser] = useState([]);

  const [token, setToken] = useState(null);



  const fetchToken = async () => {
    try {
      const storedToken = await globalStorage.getValue("token");
      console.log("Fetched Token:", storedToken); // Debugging

      if (storedToken) {
        setToken(storedToken); // State update is asynchronous
      } else {
        Alert.alert("Error", "Authentication token is missing.");
      }
    } catch (error) {
      console.error("Error fetching token:", error);
      Alert.alert("Error", "An error occurred while fetching the token.");
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

  const { control, handleSubmit, reset, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });
  // Create User
  const onSubmit = async (data:any) => {
    if (data) {
      if (token) {
        const url = `${API_BASE_URL}/master/users/new`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`
        };
        const body = JSON.stringify({
          mobile: data.Employee_phoneNumber,
          password: data.password,
          first_name: data.Employee_FName,
          last_name: data.Employee_LName,
          gender: data.gender,
          birth_date: data.birth_date,
          address: data.Employee_Address,
          email: data.email
        });
        try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          if (res.status === 200) {
            Alert.alert("Success", resJson.message);
            closeModal(); // Close the modal after successful creation
            reset(); // Reset the form state
            getAllUser();
          } else {
            Alert.alert("Error", resJson.message || "Failed to fetch states.");
          }
        } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
        }

      }
    }
  };

  // Gate all Users
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
            // Employee_FName :   
            // Employee_LName :
            // email :
            Employee_phoneNumber: user.mobile,
            Employee_Address: user.password
            // gender :
            // birth_date
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

  // Call function on page load to display
  useEffect(() => {
    fetchToken();
    if (token){
      getAllUser();
    }
  }, [token]);


  const renderBranchItem = ({ item }) => (
    <View style={styles.branchItem}>
      {/* <Text style={styles.branchTitle}>Employee Name: <Text style={styles.branchText}>{item.Employee_FName} {item.Employee_LName}</Text></Text>
      <Text style={styles.branchText}>Email: {item.email}</Text> */}
      <Text style={styles.branchText}>Phone: {item.Employee_phoneNumber}</Text>
      <Text style={styles.branchText}>Password: {item.Employee_Address}</Text>
      {/* <Text style={styles.branchText}>Gender: {item.gender}</Text>
      <Text style={styles.branchText}>Birth Date: {item.birth_date}</Text> */}
    </View>
  );

  return (
    <View style={{ flex: 1 }}>
      <FlatList
        data={User}
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
              <View style={{ gap: 3 }}>
                <View style={styles.container} className="gap-2">
                  <Controller
                    control={control}
                    name="Employee_FName"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Employee First Name"
                          mode="outlined"
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Employee_FName && <Text style={styles.errorText}>{errors.Employee_FName.message}</Text>}
                      </View>
                    )}
                  />

                  <Controller
                    control={control}
                    name="Employee_LName"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Employee Last Name"
                          mode="outlined"
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Employee_LName && <Text style={styles.errorText}>{errors.Employee_LName.message}</Text>}
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

                <Controller
                  control={control}
                  name="Employee_phoneNumber"
                  render={({ field: { onChange, value } }) => (
                    <View>
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
                  name="email"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Email"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.email && <Text style={styles.errorText}>{errors.email.message}</Text>}
                    </View>
                  )}
                />

                <Controller
                  control={control}
                  name="password"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Password"
                        mode="outlined"
                        secureTextEntry
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.password && <Text style={styles.errorText}>{errors.password.message}</Text>}
                    </View>
                  )}
                />
                <View style={styles.container} className="gap-2">
                  <Controller
                    control={control}
                    name="gender"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.pickerWrapper}>
                        <Picker
                          selectedValue={value}
                          onValueChange={(selectedValue) => onChange(selectedValue)}
                          style={styles.picker}
                        >
                          <Picker.Item label="Select Gender" value="" />
                          <Picker.Item label="Male" value="male" />
                          <Picker.Item label="Female" value="female" />
                          <Picker.Item label="Other" value="other" />
                        </Picker>
                        {errors.gender && <Text style={styles.errorText}>{errors.gender.message}</Text>}
                      </View>
                    )}
                  />

                  <Controller
                    control={control}
                    name="birth_date"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                          label="Birth Date (YYYY-MM-DD)"
                        />
                        {errors.birth_date && <Text style={styles.errorText}>{errors.birth_date.message}</Text>}
                      </View>
                    )}
                  />
                </View>

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