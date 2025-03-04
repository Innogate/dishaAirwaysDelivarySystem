import React, { useState, useRef, useCallback, useEffect } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList, Image } from 'react-native';
import { TextInput, FAB } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import * as ImagePicker from 'expo-image-picker';
import { Picker } from '@react-native-picker/picker';
import * as FileSystem from 'expo-file-system';
import { API_BASE_URL } from '@/constants/api.url';
import styles from '@/app/components/GlobalStyle';
import globalStorage from '@/app/components/GlobalStorage';

const schema = yup.object().shape({
  Company_Name: yup.string().required('Company Name is required'),
  Company_Address: yup.string().required('Company Address is required'),
  Company_City: yup.string().required('Company City is required'),
  Company_States: yup.string().required('Company State is required'),
  Company_Pincode: yup.string()
    .required('Pincode is required')
    .matches(/^[0-9]{6}$/, 'Invalid Pincode'),
  phoneNumber: yup.string()
    .required('Phone Number is required')
    .matches(/^[0-9]{10}$/, 'Invalid phone number'),
  Company_Email: yup.string()
    .email('Invalid email format')
    .required('Company Email is required'),
  Company_GST: yup.string().required('Company GST No is required'),
  Company_CIN: yup.string().required('Company CIN No is required'),
  Company_Udyam: yup.string().notRequired(), // Optional field
  Company_Logo: yup.string().required('Company Logo'),
});

const screenHeight = Dimensions.get("window").height;

const BranchMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(screenHeight)).current;
  const startY = useRef(0);
  const [selectedImage, setSelectedImage] = useState(null);
  const [loading, setLoading] = useState(false);
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

  // Get all states
  const [statesList, setStatesList] = useState([]);
  const getAllStates = useCallback(async () => {
    if (token) {
      const url = `${API_BASE_URL}/master/states`;
      const header = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      };
      const body = JSON.stringify({ from: 0 });

      try {
        const res = await fetch(url, { method: "POST", headers: header, body });
        const resJson = await res.json();
        if (res.status === 200) {
          const formattedStates = resJson.body.map((state) => ({
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

  useEffect(() => {
    fetchToken();
    if(token){
      getAllStates();
      getAllCompanies();
    }
  }, [getAllStates,token,]);

  // Get all cities by state id
  const [cityList, setCityList] = useState([]);
  const handleStateChange = async (selectedValue) => {
    if (selectedValue) {
      if (token) {
        const url = `${API_BASE_URL}/master/cities/byStateId`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        };
        const body = JSON.stringify({ from: 0, state_id: selectedValue });
        try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          if (res.status === 200) {
            const formattedCities = resJson.body.map((city) => ({
              id: city.id,
              city_name: city.name,
            }));
            setCityList(formattedCities);
          } else {
            Alert.alert("Error", resJson.message || "Failed to fetch cities.");
          }
        } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
        }
      }
    }
  };

  // Get all companies
  const [companyList, setCompanyList] = useState([]);
  const getAllCompanies = async () => {
    if (token) {
      const url = `${API_BASE_URL}/master/companies`;
      const header = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      };
      const body = JSON.stringify({ from: 0 });
      try {
        const res = await fetch(url, { method: "POST", headers: header, body });
        const resJson = await res.json();
        if (res.status === 200) {
          const formattedCompanies = resJson.body.map((company) => ({
            id: company.id,
            name: company.name,
            address: company.address,
            pin_code: company.pin_code,
            contact_no: company.contact_no,
            email: company.email,
            gst_no: company.gst_no,
            cin_no: company.cin_no,
            udyam_no: company.udyam_no,
            logo: company.logo // Assuming the logo URL is in the response
          }));
          setCompanyList(formattedCompanies);
        } else {
          Alert.alert("Error", resJson.message || "Failed to fetch companies.");
        }
      } catch (error) {
        Alert.alert("Error", "Server Error");
        console.error("Fetch error:", error);
      }
    }
  };

  // Create a new Company
  const onSubmit = async (data) => {
    const newCompany = { ...data, logo: selectedImage };

    if (newCompany) {
      if (token) {
        const url = `${API_BASE_URL}/master/companies/new`;
        const headers = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        };
        const body = JSON.stringify({
          name: newCompany.Company_Name,
          address: newCompany.Company_Address,
          city_id: newCompany.Company_City,
          state_id: newCompany.Company_States,
          pin_code: newCompany.Company_Pincode,
          contact_no: newCompany.phoneNumber,
          email: newCompany.Company_Email,
          gst_no: newCompany.Company_GST,
          cin_no: newCompany.Company_CIN,
          udyam_no: newCompany.Company_Udyam,
          logo: newCompany.Company_Logo, // Use the base64 string here
        });

        setLoading(true);
        try {
          const res = await fetch(url, { method: "POST", headers, body });
          const resJson = await res.json();

          if (res.status === 200) {
            Alert.alert("Success", "Company Created Successfully");
            getAllCompanies();
            reset(); // Reset the form after successful submission
            setSelectedImage(null); // Reset the image state
          } else {
            Alert.alert("Error", resJson.message || "Failed to create company.");
          }
        } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
        } finally {
          setLoading(false);
        }
      }
    }

    // Close the modal after form submission
    closeModal();
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

  const handleImageUpload = async (onChange) => {
    const permissionResult = await ImagePicker.requestMediaLibraryPermissionsAsync();

    if (permissionResult.granted === false) {
      alert("Permission to access camera roll is required!");
      return;
    }

    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [1, 1],
      quality: 1,
    });

    if (!result.canceled) {
      const uri = result.assets[0].uri; // Get image URI directly
      setSelectedImage(uri);
      onChange(uri); // Update form field with image URI
    }
  };


  const renderBranchItem = ({ item }) => (
    console.log(item),
    <View style={styles.branchItem}>
      <Text style={styles.branchTitle}>{item.name}</Text>
      <Text style={styles.branchText}>{item.address}</Text>
      {item.logo && (
        <Image source={{ uri: item.logo }} style={{ width: 100, height: 100 }} />)}
    </View>
  );

  return (
    <View style={{ flex: 1 }} className="bg-slate-100">
      <FlatList
        data={companyList}  // Use `companyList` instead of `branches`
        renderItem={renderBranchItem}
        keyExtractor={(item) => item.id.toString()} // Use unique `id` instead of index
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
                <Controller
                  control={control}
                  name="Company_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Company Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Company_Name && <Text style={styles.errorText}>{errors.Company_Name.message}</Text>}
                    </View>
                  )}
                />
                
                <Controller
                  control={control}
                  name="Company_Address"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Company Address"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Company_Address && <Text style={styles.errorText}>{errors.Company_Address.message}</Text>}
                    </View>
                  )}
                />
                <View style={styles.rowContainer}>
                  {/* State Picker */}
                  <Controller
                    control={control}
                    name="Company_States"
                    render={({ field: { onChange, value } }) => (
                      <View style={[styles.pickerWrapper, styles.pickerWrapperLeft]}>
                        <Picker
                          selectedValue={value}
                          onValueChange={(selectedValue) => {
                            handleStateChange(selectedValue);
                            onChange(selectedValue);
                          }}
                          style={styles.picker}
                        >
                          <Picker.Item label="Select a State" value="" />
                          {statesList.map((state) => (
                            <Picker.Item key={state.id} label={state.States_Name} value={state.id} />
                          ))}
                        </Picker>
                        {errors.Company_States && <Text style={styles.errorText}>{errors.Company_States.message}</Text>}
                      </View>
                    )}
                  />

                  {/* City Picker */}
                  <Controller
                    control={control}
                    name="Company_City"
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
                        {errors.Company_City && <Text style={styles.errorText}>{errors.Company_City.message}</Text>}
                      </View>
                    )}
                  />
                </View>
                <View style={styles.container} className="gap-2">
                  <Controller
                    control={control}
                    name="Company_Pincode"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Company Pincode"
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Company_Pincode && <Text style={styles.errorText}>{errors.Company_Pincode.message}</Text>}
                      </View>
                    )}
                  />
                  <Controller
                    control={control}
                    name="phoneNumber"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Company Phone Number"
                          mode='outlined'
                          keyboardType="numeric"
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.phoneNumber && <Text style={styles.errorText}>{errors.phoneNumber.message}</Text>}
                      </View>
                    )}
                  />
                </View>
                <Controller
                  control={control}
                  name="Company_Email"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Company Email"
                        mode='outlined'
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Company_Email && <Text style={styles.errorText}>{errors.Company_Email.message}</Text>}
                    </View>
                  )}
                />

                <View style={styles.container} className='gap-2'>
                  <Controller
                    control={control}
                    name="Company_GST"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Company GST No"
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Company_GST && <Text style={styles.errorText}>{errors.Company_GST.message}</Text>}
                      </View>
                    )}
                  />

                  <Controller
                    control={control}
                    name="Company_CIN"
                    render={({ field: { onChange, value } }) => (
                      <View style={styles.twoinputContainer}>
                        <TextInput
                          label="Company CIN No"
                          mode='outlined'
                          value={value}
                          onChangeText={onChange}
                          style={styles.input}
                        />
                        {errors.Company_CIN && <Text style={styles.errorText}>{errors.Company_CIN.message}</Text>}
                      </View>
                    )}
                  />
                </View>

                <Controller
                  control={control}
                  name="Company_Udyam"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="Company Udyam No"
                        mode='outlined'
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.Company_Udyam && <Text style={styles.errorText}>{errors.Company_Udyam.message}</Text>}
                    </View>
                  )}
                />
                <Controller
                  control={control}
                  name="Company_Logo"
                  render={({ field: { onChange, value } }) => (
                    <View style={{ alignItems: 'center', marginVertical: 10 }}>
                      {/* Show the selected image or placeholder text */}
                      {value ? (
                        <Image source={{ uri: value }} style={{ width: 100, height: 100, borderRadius: 10 }} />
                      ) : (
                        <Text>No Image Selected</Text>
                      )}

                      {/* Upload Image Button */}
                      <TouchableOpacity style={styles.button} onPress={() => handleImageUpload(onChange)}>
                        <Text style={styles.buttonText}>Upload Image</Text>
                      </TouchableOpacity>

                      {/* Error Message */}
                      {errors.Company_Logo && <Text style={styles.errorText}>{errors.Company_Logo.message}</Text>}
                    </View>
                  )}
                />

                <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)} disabled={loading}>
                  <Text style={styles.buttonText}>{loading ? 'Submitting...' : 'SUBMIT'}</Text>
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