import React, { useState, useRef } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB, Button } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import * as ImagePicker from 'expo-image-picker';
import { Picker } from '@react-native-picker/picker'; // Import Picker for gender selection
import styles from '@/app/components/GlobalStyle';
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
  Join_Date: yup.string().required('Join Date is required').matches(/^\d{4}-\d{2}-\d{2}$/, 'Date must be in YYYY-MM-DD format'),
  Date_of_Birth: yup.string().required('Date of Birth is required').matches(/^\d{4}-\d{2}-\d{2}$/, 'Date must be in YYYY-MM-DD format'),
  Gender: yup.string().required('Gender is required'),
});

const screenHeight = Dimensions.get("window").height;

const EmployeeMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(500)).current;
  const startY = useRef(0);

  const [branches, setBranches] = useState([]);
  const [joinDate, setJoinDate] = useState('');
  const [dob, setDob] = useState('');
  const [gender, setGender] = useState('');

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

  const { control, handleSubmit, setValue, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const onSubmit = async (data) => {
    // const newBranch = { ...data, Join_Date: joinDate, Date_of_Birth: dob, Gender: gender };
    // setBranches([...branches, newBranch]);
    // Alert.alert('Form Submitted', JSON.stringify(newBranch, null, 2));
    // closeModal();
  };

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
      <Text style={styles.branchTitle}>Employee Name: <Text style={styles.branchText}>{item.Employee_Name}</Text></Text>
      <Text style={styles.branchText}>Address: {item.Employee_Address}</Text>
      <Text style={styles.branchText}>Phone: {item.Employee_phoneNumber}</Text>
      <Text style={styles.branchText}>Aadhar: {item.Employee_AadharNo}</Text>
      <Text style={styles.branchText}>Join Date: {item.Join_Date}</Text>
      <Text style={styles.branchText}>Date of Birth: {item.Date_of_Birth}</Text>
      <Text style={styles.branchText}>Gender: {item.Gender}</Text>
    </View>
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
            {...panResponder.panHandlers}
            style={[styles.modalContent, { transform: [{ translateY: slideAnim }] }]}
          >
            <ScrollView contentContainerStyle={{ flexGrow: 1, paddingBottom: 80, minHeight: screenHeight * 0.6 }} showsVerticalScrollIndicator={false} keyboardShouldPersistTaps="handled">
              <View className="gap-2">
                <Controller
                  control={control}
                  name="Employee_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Employee Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Employee_Name && <Text style={styles.errorText}>{errors.Employee_Name.message}</Text>}
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