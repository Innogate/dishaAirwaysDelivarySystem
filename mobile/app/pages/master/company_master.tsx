import React, { useState, useRef, useCallback, useEffect } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList, Image, TouchableWithoutFeedback } from 'react-native';
import { TextInput, FAB } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import * as ImagePicker from 'expo-image-picker';
import { Picker } from '@react-native-picker/picker';
import { environment } from '@/app/environment/environment';

// Define the validation schema
const schema = yup.object().shape({
  Company_Name: yup.string().required('Company Name is required'),
  Company_Address: yup.string().required('Company Address is required'),
  Company_City: yup.string().required('Company City is required'),
  Company_States: yup.string().required('Company State is required'),
  Company_Pincode: yup.string()
    .required('Company Pincode is required')
    .matches(/^[0-9]{6}$/, 'Invalid Pincode'),
  phoneNumber: yup.string()
    .required('Company Phone Number is required')
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

const BranchMaster = ( ) => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(screenHeight)).current;
  const startY = useRef(0);
  const [selectedImage, setSelectedImage] = useState(null);
  const [branches, setBranches] = useState([]);

  // gate all states
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
  useEffect(() => {
    getAllStates();
    getAllCompanies();
  }, [getAllStates]);

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

  // Gate all company
  const [companyList, setCompanyList] = useState([]);
  const getAllCompanies = async () => {
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
          const formattedStates = resJson.body.map((company: { id: any; name: any; address: any; pin_code: any; contact_no: any; email: any; gst_no: any; cin_no: any; udyam_no: any }) => ({
            id: company.id,
            name: company.name,
            address: company.address,
            // city_id: 1,
            // state_id: 1,
            pin_code: company.pin_code,
            contact_no: company.contact_no,
            email: company.email,
            gst_no: company.gst_no,
            cin_no: company.cin_no,
            udyam_no: company.udyam_no
          }));
          setCompanyList(formattedStates);
        } else {
          Alert.alert("Error", resJson.message || "Failed to fetch states.");
        }
      } catch (error) {
        Alert.alert("Error", "Server Error");
        console.error("Fetch error:", error);
      }


    }
  }


  // Create a new Company
  const onSubmit = async (data: any) => {
    const newCompany = { ...data, logo: selectedImage };
    
    if (newCompany) {
      const token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";
      
      if (token) {
        const url = `${environment.apiUrl}/master/companies/new`;
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
          logo: "base64_encoded_string"
        });
  
        try {
          const res = await fetch(url, { method: "POST", headers, body });
          const resJson = await res.json();
  
          if (res.status === 200) {
            Alert.alert("Success", "Company Created Successfully");
  
            // Refresh the company list
            getAllCompanies();
  
            // Reset the form fields
            reset(); // Reset the form after successful submission
          } else {
            console.log(resJson);
            Alert.alert("Error", resJson.message || "Failed to create company.");
          }
        } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
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

  const { control, handleSubmit, setValue,reset, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const handleImageUpload = async (onChange: any) => {
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
      const uri = result.assets[0].uri;
      setSelectedImage(uri);
      onChange(uri); // Update form field
    }
  };

  const renderBranchItem = ({ item }) => (
    <View style={styles.branchItem}>
      <Text style={styles.branchTitle}>{item.name}</Text>
      <Text style={styles.branchText}>{item.address}</Text>
      {item.logo && (
        <Image source={{ uri: item.logo }} style={{ width: 50, height: 50 }} />
      )}
    </View>
  );

  return (
    <View style={{ flex: 1 }}>
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
              <View style={{ gap: 2 }}>
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


                <Controller
                  control={control}
                  name="Company_States"
                  render={({ field: { onChange, value } }) => (
                    <View className="border">
                      <Picker
                        selectedValue={value}
                        onValueChange={(selectedValue) => {
                          handleStateChange(selectedValue);
                          onChange(selectedValue); // Update form state
                        }}
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

                <Controller
                  control={control}
                  name="Company_City"
                  render={({ field: { onChange, value } }) => (
                    <View style={{ borderWidth: 1, padding: 0, margin: 0 }}>
                      <Picker
                        selectedValue={value}
                        onValueChange={(selectedValue) => onChange(selectedValue)}
                        style={{ margin: 0, padding: 0 }}
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

                <Controller
                  control={control}
                  name="Company_Pincode"
                  render={({ field: { onChange, value } }) => (
                    <View>
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
                    <View>
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

                <Controller
                  control={control}
                  name="Company_GST"
                  render={({ field: { onChange, value } }) => (
                    <View>
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
                    <View>
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
                      {selectedImage || value ? (
                        <Image source={{ uri: selectedImage || value }} style={{ width: 100, height: 100, borderRadius: 10 }} />
                      ) : (
                        <Text>No Image Selected</Text>
                      )}
                      <TouchableOpacity
                        style={styles.button}
                        onPress={() => handleImageUpload(onChange)}
                      >
                        <Text style={styles.buttonText}>Upload Image</Text>
                      </TouchableOpacity>
                      {errors.Company_Logo && <Text style={styles.errorText}>{errors.Company_Logo.message}</Text>}
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
    borderRadius: 8,
    height: 40,
    fontSize: 12,
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


export default BranchMaster;