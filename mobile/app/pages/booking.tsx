import React, { useCallback, useEffect, useState } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet } from 'react-native';
import { TextInput } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import { Picker } from '@react-native-picker/picker';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import styles from '../components/GlobalStyle';
import { API_BASE_URL } from '@/constants/api.url';
import globalStorage from '../components/GlobalStorage';

// Define the validation schema
const schema = yup.object().shape({
  bookingNo: yup.string().required('Booking No is required'),
  consignor: yup.string().required('Consignor is required'),
  phoneNumber: yup.string()
    .required('Phone number is required')
    .matches(/^[0-9]{10}$/, 'Invalid phone number'),
  consignee: yup.string().required('Consignee is required'),
  consigneePhoneNumber: yup.string()
    .required('Consignee Phone number is required')
    .matches(/^[0-9]{10}$/, 'Invalid phone number'),
  destination_city: yup.string().required('Destination City is required'),
  destination_States: yup.string().required('Destination States is required'),
  branch: yup.string().required('Branch is required'),
  transportType: yup.string().required('Select a transport type'),
  packages: yup.number().required('No. of Packages is required').positive().integer(),
  weight: yup.number().required('Weight is required').positive(),
  declaredValue: yup.number().required('Declared Value is required').positive(),
  totalValue: yup.number().required('Total Value is required').positive(),
  contain: yup.number().positive().notRequired(),
  charges: yup.number().positive().notRequired(),
  shipper: yup.number().positive().notRequired(),
  igst: yup.number().positive().notRequired(),
  sgst: yup.number().positive().notRequired(),
  cgst: yup.number().positive().notRequired(),
});


console.log(2);
const BookingForm = () => {
  console.log(1);
  const [token, setToken] = useState(null);
  const [BranchList, setBranchList] = useState([]);
  const [statesList, setStatesList] = useState([]);
  const [cityList, setcityList] = useState([]);

  const fetchToken = async () => {
    const storedToken = await globalStorage.getValue("token");
    console.log("Fetched Token:", storedToken); // Debugging
    if (storedToken) {
      setToken(storedToken);
    } else {
      Alert.alert("Error", "Authentication token missing.");
    }
  };

  const onSubmit = async (data) => {
    if (!token) {
      Alert.alert("Error", "Authentication token missing.");
      return;
    }

    if (data) {
      const url = `${API_BASE_URL}/booking/new`;

      const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`
      };

      const body = JSON.stringify({

          slip_no: data.bookingNo,
          consignee_name: data.consignee,
          consignor_name: data.consignor,
          consignee_mobile: data.consigneePhoneNumber,
          consignor_mobile: data.phoneNumber,
          transport_mode: data.transportType,
          paid_type: "Prepaid",
          destination_city_id: data.destination_city,
          destination_branch_id: 1,
          count: data.packages,
          weight: data.weight,
          value: data.declaredValue,
          contents: data.contain,
          charges: data.charges,
          shipper: data.shipper,
          cgst: data.cgst,
          sgst: data.sgst,
          igst: data.igst
        });
        
        try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          if (res.status === 200) {
            Alert.alert("Success", resJson.message);
          } else {
            Alert.alert("Error", resJson.message || "Failed to fetch states.");
          }
        } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
        }
    }
  };

  // SELECT Branch by city_id
  const handleCitySelection = async (cityId) => {
    if (!token) {
      Alert.alert("Error", "Authentication token missing.");
      return;
    }
    
    if (cityId) {
      console.log(cityId);
      const url = `${API_BASE_URL}/master/branches`;
      const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`
      };
      const body = JSON.stringify({ from: 0, city_id: cityId });

      try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          if (res.status === 200) {
            const formattedBranch = resJson.body.map((Branch: { id: any; name: any; }) => ({
              id: Branch.id,
              Branch_name: Branch.name,
            }));
            console.log(formattedBranch);
            setBranchList(formattedBranch);
          } else {
            Alert.alert("Error", resJson.message || "Failed to fetch Branch.");
          }
      } catch (error) {
          Alert.alert("Error", "Server Error");
          console.error("Fetch error:", error);
      }
    };
  }

  // GET ALL STATES
  const getAllStates = useCallback(async () => {

    if (!token) {
      Alert.alert("Error", "Authentication token missing.");
      return;
    }

    const url = `${API_BASE_URL}/master/states`;

    const header = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`
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
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      await fetchToken(); // Ensure token is fetched first
      await getAllStates(); // Only call this after the token is available
    };
  
    if (!token) {
      fetchData();
    } else {
      getAllStates();
    }
  }, [token]);

  const { control, handleSubmit, setValue, reset, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const currentDate = new Date();
  const formattedDate = `${String(currentDate.getDate()).padStart(2, "0")}/${String(currentDate.getMonth() + 1).padStart(2, "0")}/${currentDate.getFullYear()}`;
  
  const handleStateChange = async (selectedValue: any) => {
    console.log("Selected State ID:", selectedValue);
    if (selectedValue) {
      if (token) {
        const url = `${API_BASE_URL}/master/cities/byStateId`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`
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

  return (
    <ScrollView className="flex-1 bg-slate-100 px-4" contentContainerStyle={{ paddingBottom: 20 }} showsVerticalScrollIndicator={false}>
      <Text className="mt-2">Date: {formattedDate}</Text>
      {/* Booking No & Consignor */}
      <View className="gap-2">
        <View style={styles.container} className="gap-2">
          <Controller
            control={control}
            name="bookingNo"
            render={({ field: { onChange, onBlur, value } }) => (
              <View style={styles.twoinputContainer}>
                <TextInput
                  label="Booking No"
                  value={value}
                  mode="outlined"
                  keyboardType="numeric"
                  onBlur={onBlur}
                  onChangeText={onChange}
                  style={[styles.input]}
                />
                {errors.bookingNo && <Text style={styles.errorText}>{errors.bookingNo.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="consignor"
            render={({ field: { onChange, value } }) => (
              <View style={styles.twoinputContainer}>
                <TextInput
                  label="Consignor"
                  mode="outlined"
                  value={value}
                  onChangeText={onChange}
                  style={[styles.input]}
                />
                {errors.consignor && <Text style={styles.errorText}>{errors.consignor.message}</Text>}
              </View>
            )}
          />
        </View>

        {/* Phone Number */}
        <Controller
          control={control}
          name="phoneNumber"
          render={({ field: { onChange, value } }) => (
            <View>
              <TextInput
                label="Phone Number"
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
        {/* Consignee */}
        <Controller
          control={control}
          name="consignee"
          render={({ field: { onChange, value } }) => (
            <View>
              <TextInput
                label="Consignee"
                mode='outlined'
                value={value}
                onChangeText={onChange}
                style={styles.input}
              />
              {errors.consignee && <Text style={styles.errorText}>{errors.consignee.message}</Text>}
            </View>
          )}
        />
        <Controller
          control={control}
          name="consigneePhoneNumber"
          render={({ field: { onChange, value } }) => (
            <View>
              <TextInput
                label="Consignee Phone Number"
                mode='outlined'
                keyboardType="numeric"
                value={value}
                onChangeText={onChange}
                style={styles.input}
              />
              {errors.consigneePhoneNumber && <Text style={styles.errorText}>{errors.consigneePhoneNumber.message}</Text>}
            </View>
          )}
        />
        <View style={styles.rowContainer}>
          {/* State Picker */}
          <Controller
            control={control}
            name="destination_States"
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
                {errors.destination_States && <Text style={styles.errorText}>{errors.destination_States.message}</Text>}
              </View>
            )}
          />

          <Controller
            control={control}
            name="destination_city"
            render={({ field: { onChange, value } }) => (
              <View style={styles.pickerWrapper}>
                <Picker
                  selectedValue={value}
                  onValueChange={(selectedValue) => {
                    onChange(selectedValue); // Update the form state
                    handleCitySelection(selectedValue); // Call the method with the selected city ID
                  }}
                >
                  <Picker.Item label="Destination City" value="" />
                  {cityList.map((city) => {
                    // Ensure city.id is unique
                    if (!city.id) {
                      console.warn("City ID is missing for city:", city);
                    }
                    return (
                      <Picker.Item key={city.id} label={city.city_name} value={city.id} />
                    );
                  })}
                </Picker>
                {errors.destination_city && <Text style={styles.errorText}>{errors.destination_city.message}</Text>}
              </View>
            )}
          />

          {/* City Picker */}
          {/* <Controller
            control={control}
            name="destination_city"
            render={({ field: { onChange, value } }) => (
              <View style={styles.pickerWrapper}>
                <Picker
                  selectedValue={value}
                  onValueChange={(selectedValue) => {
                    onChange(selectedValue); // Update the form state
                    handleCitySelection(selectedValue); // Call the method with the selected city ID
                  }}
                  style={styles.picker}
                >
                  <Picker.Item label="Destination City" value="" />
                  {cityList.map((city) => (
                    <Picker.Item key={city.id} label={city.city_name} value={city.id} />
                  ))}
                </Picker>
                {errors.destination_city && <Text style={styles.errorText}>{errors.destination_city.message}</Text>}
              </View>
            )}
          /> */}
        </View>

        <Controller
          control={control}
          name="branch"
          render={({ field: { onChange, value } }) => (
            <View style={styles.pickerWrapper}>
              <Picker
                selectedValue={value}
                onValueChange={(selectedValue) => onChange(selectedValue)}
                style={styles.picker}
              >
                <Picker.Item label="Destination Branch" value="" />
                {BranchList.map((branch) => (
                  <Picker.Item key={branch.id} label={branch.Branch_name} value={branch.id} />
                ))}
              </Picker>
              {errors.branch && <Text style={styles.errorText}>{errors.branch.message}</Text>}
            </View>
          )}
        />

        <Controller
          control={control}
          name="transportType"
          render={({ field: { onChange, value } }) => (
            <View style={styles.pickerWrapper}>
              <Picker selectedValue={value} onValueChange={(itemValue) => setValue('transportType', itemValue)} style={styles.picker}>
                <Picker.Item label="Select Transport Type" value="" />
                <Picker.Item label="Air" value="air" />
                <Picker.Item label="Road" value="road" />
                <Picker.Item label="Rail" value="rail" />
                <Picker.Item label="Sea" value="sea" />
              </Picker>
              {errors.transportType && <Text style={styles.errorText}>{errors.transportType.message}</Text>}
            </View>
          )}
        />
        <View style={styles.threeFieldContainer}>
          <Controller
            control={control}
            name="packages"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput
                  label="No of Packages"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={styles.input}
                />
                {errors.packages && <Text style={styles.errorText}>{errors.packages.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="weight"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput
                  label="Weight"
                  mode='outlined'
                  keyboardType="numeric"
                  value={value}
                  onChangeText={onChange}
                  style={styles.input}
                />
                {errors.weight && <Text style={styles.errorText}>{errors.weight.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="declaredValue"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput
                  label="Declared Value"
                  mode='outlined'
                  keyboardType="numeric"
                  value={value}
                  onChangeText={onChange}
                  style={styles.input}
                />
                {errors.declaredValue && <Text style={styles.errorText}>{errors.declaredValue.message}</Text>}
              </View>
            )}
          />
        </View>

        <View style={styles.threeFieldContainer}>
          <Controller
            control={control}
            name="contain"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput label="Contain" mode='outlined' value={value} onChangeText={onChange} style={styles.input} />
                {errors.contain && <Text style={styles.errorText}>{errors.contain.message}</Text>}
              </View>
            )}
          />

          <Controller
            control={control}
            name="charges"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput label="Charges" mode='outlined' value={value} onChangeText={onChange} style={styles.input} keyboardType="numeric" />
                {errors.charges && <Text style={styles.errorText}>{errors.charges.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="shipper"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput label="Shipper's" mode='outlined' value={value} onChangeText={onChange} style={styles.input} keyboardType="numeric" />
                {errors.shipper && <Text style={styles.errorText}>{errors.shipper.message}</Text>}
              </View>
            )}
          />
        </View>

        {/* Taxes */}
        <View style={styles.threeFieldContainer}>
          <Controller
            control={control}
            name="cgst"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput
                  label="CGST"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={styles.input}
                  keyboardType="numeric"
                />
                {errors.cgst && <Text style={styles.errorText}>{errors.cgst.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="sgst"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput
                  label="SGST"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={styles.input}
                  keyboardType="numeric"
                />
                {errors.sgst && <Text style={styles.errorText}>{errors.sgst.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="igst"
            render={({ field: { onChange, value } }) => (
              <View style={styles.inputWrapper}>
                <TextInput
                  label="IGST"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={styles.input}
                  keyboardType="numeric"
                />
                {errors.igst && <Text style={styles.errorText}>{errors.igst.message}</Text>}
              </View>
            )}
          />
        </View>

        {/* Total Value */}
        <Controller
          control={control}
          name="totalValue"
          render={({ field: { onChange, value } }) => (
            <View>
              <TextInput
                label="Total Value"
                mode='outlined'
                keyboardType="numeric"
                value={value}
                onChangeText={onChange}
                style={styles.input}
              />
              {errors.totalValue && <Text style={styles.errorText}>{errors.totalValue.message}</Text>}
            </View>
          )}
        />
        {/* Submit Button */}
        <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)}>
          <Text style={styles.buttonText}>SUBMIT</Text>
        </TouchableOpacity>
      </View>
    </ScrollView >
  );
};

export default BookingForm;