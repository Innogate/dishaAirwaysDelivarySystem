import React, { useState, useRef, useEffect } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { environment } from '@/app/environment/environment';

// Define the validation schema
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
  const onSubmit = async (data) => {
    console.log('Form submitted with data:', data); // Log the submitted data
    if (data) {
      const token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";
      if (token) {
        const url = `${environment.apiUrl}/master/users/new`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
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
  const token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";

  if (token) {
    const url = environment.apiUrl + "/master/users";
    const header = {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
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
          Employee_phoneNumber : user.mobile,
          Employee_Address : user.password
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
    getAllUser();
  }, []);


  const renderBranchItem = ({ item }) => (
    <View style={styles.branchItem}>
      <Text style={styles.branchTitle}>Employee Name: <Text style={styles.branchText}>{item.Employee_FName} {item.Employee_LName}</Text></Text>
      <Text style={styles.branchText}>Email: {item.email}</Text>
      <Text style={styles.branchText}>Phone: {item.Employee_phoneNumber}</Text>
      <Text style={styles.branchText}>Address: {item.Employee_Address}</Text>
      <Text style={styles.branchText}>Gender: {item.gender}</Text>
      <Text style={styles.branchText}>Birth Date: {item.birth_date}</Text>
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
              <View>
                <Controller
                  control={control}
                  name="Employee_FName"
                  render={({ field: { onChange, value } }) => (
                    <View>
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
                    <View>
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

                <Controller
                  control={control}
                  name="gender"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Gender"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.gender && <Text style={styles.errorText}>{errors.gender.message}</Text>}
                    </View>
                  )}
                />

                <Controller
                  control={control}
                  name="birth_date"
                  render={({ field: { onChange, value } }) => (
                    <View>
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
    paddingVertical: 0,
    paddingHorizontal: 0,
    margin: 0,
    fontSize: 10,
    height: 40,
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
    elevation: 3,
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
});

export default EmployeeMaster;