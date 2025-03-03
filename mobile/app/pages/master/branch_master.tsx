import React, { useState, useRef, useCallback, useEffect } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB } from 'react-native-paper'; // Import FAB from react-native-paper
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import * as ImagePicker from 'expo-image-picker'; // Import expo-image-picker
import { environment } from '@/app/environment/environment';
import { Picker } from '@react-native-picker/picker';
import styles from '@/app/components/GlobalStyle';
// Define the validation schema
const schema = yup.object().shape({
  Company_name: yup.string().required('Company Name is required'),
  Branch_Name: yup.string().required('Branch Name is required'),
  Branch_Address: yup.string().required('Branch Address is required'),
  Branch_City: yup.string().required('Branch City is required'),
  Branch_Pincode: yup.string()
    .required('Branch Pincode is required')
    .matches(/^[0-9]{6}$/, 'Invalid Pincode'),
  Branch_Contact_No: yup.string()
    .required('Branch Phone Number is required')
    .matches(/^[0-9]{10}$/, 'Invalid phone number'),
  Branch_Email: yup.string()
    .email('Invalid email format')
    .required('Branch Email is required'),
  Branch_GST: yup.string().required('Branch GST No is required'),
  Branch_CIN: yup.string().required('Branch CIN No is required'),
  Branch_Udyam: yup.string().notRequired(), // Optional field
  logo: yup.mixed().required('Branch Logo is required'),
  Branch_ShortName: yup.string().required('Branch Short Name is required'),
  Branch_States: yup.string().required('Branch States'),
  // Logo field


});

const screenHeight = Dimensions.get("window").height;

const BranchMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(500)).current;
  const startY = useRef(0);

  //gate all state
  const [statesList, setStatesList] = useState([]);
  const getAllStates = useCallback(async () => {
    const token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";
    if (token) {
      const url = `${environment.apiUrl}/master/states`;
      const header = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      };
      const body = JSON.stringify({ from: 0 });

      try {
        const res = await fetch(url, { method: "POST", headers: header, body });
        const resJson = await res.json();
        if (res.status === 200) {
          const formattedStates = resJson.body.map((state: { id: any; name: any; }) => ({
            id: state.id,
            States_Name: state.name,
          }));
          setStatesList(formattedStates);
        } else {
          Alert.alert("Error", resJson.message || "Failed to fetch states.");
        }
      } catch (error) {
        Alert.alert("Error", "Server Error");
        console.error("Fetch error:", error);
      }
    }
  }, []);

  // get all city by states id
  const [cityList, setcityList] = useState([]);
  const handleStateChange = async (selectedValue: any) => {
    console.log("Selected State ID:", selectedValue);
    if (selectedValue) {
      const token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";
      if (token) {
        const url = `${environment.apiUrl}/master/cities/byStateId`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        };
        const body = JSON.stringify({ from: 0, state_id: selectedValue });
        try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          if (res.status === 200) {
            const formattedStates = resJson.body.map((state: { id: any; name: any; }) => ({
              id: state.id,
              city_name: state.name,
            }));
            setcityList(formattedStates);
          } else {
            Alert.alert("Error", resJson.message || "Failed to fetch states.");
          }
        } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
        }

      }
    };
  }

  // gate all company
  const [companyList, setcompanyList] = useState([]);
  const getAllCompany = useCallback(async () => {
    const token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";
    if (token) {
      const url = `${environment.apiUrl}/master/companies`;
      const header = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      };
      const body = JSON.stringify({ from: 0 });

      try {
        const res = await fetch(url, { method: "POST", headers: header, body });
        const resJson = await res.json();
        if (res.status === 200) {
          const formattedStates = resJson.body.map((state: { id: any; name: any; }) => ({
            id: state.id,
            Company_Name: state.name,
          }));
          setcompanyList(formattedStates);
        } else {
          Alert.alert("Error", resJson.message || "Failed to fetch states.");
        }
      } catch (error) {
        Alert.alert("Error", "Server Error");
        console.error("Fetch error:", error);
      }
    }
  }, []);

  useEffect(() => {
    getAllStates();
    getAllCompany();
  }, [getAllStates]);

  // Initialize with static values
  const [branches, setBranches] = useState([
    {
      Branch_Name: "ABC Corp",
      Branch_Address: "123 Main St",
      Branch_City: "New York",
      Branch_Pincode: "10001",
      phoneNumber: "1234567890",
      Branch_Email: "contact@abccorp.com",
      Branch_GST: "GST123456",
      Branch_CIN: "CIN123456",
      Branch_Udyam: "Udyam123456",
      logo: "https://example.com/logo1.png"
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

  const { control, handleSubmit, setValue, reset, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const [logoUri, setLogoUri] = useState(null); // State to hold the logo URI

  const onSubmit = async (data) => {
    if (data) {
      const token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";
      if (token) {
        const url = `${environment.apiUrl}/master/branches/new`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        };
        const body = JSON.stringify({
          company_id: data.Company_name,
          name: data.Branch_Name,
          address: data.Branch_Address,
          alias_name: "Nbranch",
          city_id: data.Branch_City,
          state_id: data.Branch_States,
          pin_code: data.Branch_Pincode,
          contact_no: data.Branch_Contact_No,
          email: data.Branch_Email,
          gst_no: data.Branch_GST,
          cin_no: data.Branch_CIN,
          udyam_no: data.Branch_Udyam,
          logo: "u"
        });
        try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          if (res.status === 200) {
            Alert.alert("Success", "Branch created successfully.");
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
        Order #: <Text className="text-blue-600">{item.Branch_Name}</Text>
      </Text>
      <Text className="text-gray-500">{item.Branch_Name}</Text>

      <View className="flex-row justify-between items-center mt-2">
        <View className="bg-gray-200 px-3 py-1 rounded-full">
          <Text className="text-gray-700">{item.Branch_Name}</Text>
        </View>
        <Text className="text-lg font-bold">{item.Branch_Name}</Text>
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

                {/* <Controller
                  control={control}
                  name="Company_name"
                  render={({ field: { onChange, value } }) => (
                    <View className="border">
                      <Picker
                        selectedValue={value}
                        onValueChange={(selectedValue) => {
                          onChange(selectedValue); // Update form state
                        }}
                      >
                        <Picker.Item label="Select Company" value="" />
                        {companyList.map((Company) => (
                          <Picker.Item key={Company.id} label={Company.Company_Name} value={Company.id} />
                        ))}
                      </Picker>
                      {errors.Company_name && <Text style={styles.errorText}>{errors.Company_name.message}</Text>}
                    </View>
                  )}
                /> */}
                <Controller
                  control={control}
                  name="Company_name"
                  render={({ field: { onChange, value } }) => (
                    <View style={styles.pickerWrapper}>
                      <Picker
                        selectedValue={value}
                        onValueChange={(selectedValue) => {
                          onChange(selectedValue);
                        }}
                        style={styles.picker}
                      >
                        <Picker.Item label="Select Company" value="" />
                        {companyList.map((Company) => (
                          <Picker.Item key={Company.id} label={Company.Company_Name} value={Company.id} />
                        ))}
                      </Picker>

                      {errors.Company_name && <Text style={styles.errorText}>{errors.Company_name.message}</Text>}
                    </View>
                  )}
                />

                <Controller
                  control={control}
                  name="Branch_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Branch Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Branch_Name && <Text style={styles.errorText}>{errors.Branch_Name.message}</Text>}
                    </View>
                  )}
                />

                {/* Branch Address */}
                <Controller
                  control={control}
                  name="Branch_Address"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Branch Address"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Branch_Address && <Text style={styles.errorText}>{errors.Branch_Address.message}</Text>}
                    </View>
                  )}
                />

                <View style={styles.rowContainer}>
                  {/* State Picker */}
                  <Controller
                    control={control}
                    name="Branch_States"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.pickerWrapper}>
                        <Picker
                          selectedValue={value}
                          onValueChange={(selectedValue) => {
                            handleStateChange(selectedValue);
                            onChange(selectedValue); // Update form state
                          }}
                          style={styles.picker}
                        >
                          <Picker.Item label="Select a State" value="" />
                          {statesList.map((state) => (
                            <Picker.Item key={state.id} label={state.States_Name} value={state.id} />
                          ))}
                        </Picker>
                        {errors.Branch_States && <Text style={styles.errorText}>{errors.Branch_States.message}</Text>}
                      </View>
                    )}
                  />

                  {/* City Picker */}
                  <Controller
                    control={control}
                    name="Branch_City"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.pickerWrapper}>
                        <Picker
                          selectedValue={value}
                          onValueChange={(selectedValue) => onChange(selectedValue)}
                          style={styles.picker}
                        >
                          <Picker.Item label="Select a City" value="" />
                          {cityList.map((city) => (
                            <Picker.Item key={city.id} label={city.city_name} value={city.id} />
                          ))}
                        </Picker>
                        {errors.Branch_City && <Text style={styles.errorText}>{errors.Branch_City.message}</Text>}
                      </View>
                    )}
                  />
                </View>

                <View style={styles.container} className="gap-2">
                  {/* Branch Pincode */}
                  <Controller
                    control={control}
                    name="Branch_Pincode"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Branch Pincode"
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Branch_Pincode && <Text style={styles.errorText}>{errors.Branch_Pincode.message}</Text>}
                      </View>
                    )}
                  />

                  <Controller
                    control={control}
                    name="Branch_ShortName"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Branch Short Name"
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Branch_ShortName && <Text style={styles.errorText}>{errors.Branch_ShortName.message}</Text>}
                      </View>
                    )}
                  />
                </View>

                {/* Branch Short Name */}


                {/* Branch Contact No */}
                <Controller
                  control={control}
                  name="Branch_Contact_No"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Branch Contact No"
                        mode='outlined'
                        keyboardType="numeric"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Branch_Contact_No && <Text style={styles.errorText}>{errors.Branch_Contact_No.message}</Text>}
                    </View>
                  )}
                />

                {/* Branch Email */}
                <Controller
                  control={control}
                  name="Branch_Email"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Branch Email"
                        mode='outlined'
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Branch_Email && <Text style={styles.errorText}>{errors.Branch_Email.message}</Text>}
                    </View>
                  )}
                />

                {/* Branch GST No */}
                <Controller
                  control={control}
                  name="Branch_GST"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Branch GST No"
                        mode='outlined'
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Branch_GST && <Text style={styles.errorText}>{errors.Branch_GST.message}</Text>}
                    </View>
                  )}
                />

                {/* Branch CIN No */}
                <Controller
                  control={control}
                  name="Branch_CIN"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Branch CIN No"
                        mode='outlined'
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Branch_CIN && <Text style={styles.errorText}>{errors.Branch_CIN.message}</Text>}
                    </View>
                  )}
                />

                {/* Branch Udyam No */}
                <Controller
                  control={control}
                  name="Branch_Udyam"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Branch Udyam No"
                        mode='outlined'
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Branch_Udyam && <Text style={styles.errorText}>{errors.Branch_Udyam.message}</Text>}
                    </View>
                  )}
                />

                {/* Branch Logo Upload Field */}
                <View>
                  <TouchableOpacity onPress={handleLogoUpload} style={styles.button}>
                    <Text style={styles.buttonText}>{logoUri ? 'Change Logo' : 'Upload Logo'}</Text>
                  </TouchableOpacity>
                  {errors.logo && <Text style={styles.errorText}>{errors.logo.message}</Text>}
                  {logoUri && <Text style={styles.logoText}>Logo uploaded: {logoUri}</Text>}
                </View>

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
export default BranchMaster;