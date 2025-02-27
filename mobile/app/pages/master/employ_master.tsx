import React from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet } from 'react-native';
import { TextInput } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';

// Define the validation schema
const schema = yup.object().shape({
  Company_Name: yup.string().required('Company Name is required'),
  Company_Address: yup.string().required('Company Address is required'),
  Company_City: yup.string().required('Company City is required'),
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
});

const EnployMaster = () => {
  const { control, handleSubmit, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  interface FormData {
    Company_Name: string;
    Company_Address: string;
    Company_City: string;
    Company_Pincode: string;
    phoneNumber: string;
    Company_Email: string;
    Company_GST: string;
    Company_CIN: string;
    Company_Udyam?: string;
  }

  const onSubmit = async (data: FormData) => {
    // If no errors, proceed with form submission
    console.log('Form Data:', data);
    Alert.alert('Form Submitted', JSON.stringify(data, null, 2));
  };

  const currentDate = new Date();
  const formattedDate = `${String(currentDate.getDate()).padStart(2, "0")}/${String(currentDate.getMonth() + 1).padStart(2, "0")}/${currentDate.getFullYear()}`;

  return (
    <ScrollView className="flex-1 bg-slate-100 px-4" contentContainerStyle={{ paddingBottom: 20 }} showsVerticalScrollIndicator={false}>
      <Text className="mt-2">Date: {formattedDate}</Text>
      <View className="gap-2">
        {/* Company Name */}
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
                style={stylesx.input}
              />
              {errors.Company_Name && <Text style={styles.errorText}>{errors.Company_Name.message}</Text>}
            </View>
          )}
        />
        
        {/* Company Address */}
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
                style={stylesx.input}
              />
              {errors.Company_Address && <Text style={styles.errorText}>{errors.Company_Address.message}</Text>}
            </View>
          )}
        />
        
        <View style={stylesin.container} className="gap-2">
          {/* Company City */}
          <Controller
            control={control}
            name="Company_City"
            render={({ field: { onChange, value } }) => (
              <View style={stylesin.inputContainer}>
                <TextInput
                  label="Company City"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={stylesin.input}
                />
                {errors.Company_City && <Text style={styles.errorText}>{errors.Company_City.message}</Text>}
              </View>
            )}
          />
          
          {/* Company Pincode */}
          <Controller
            control={control}
            name="Company_Pincode"
            render={({ field: { onChange, value } }) => (
              <View style={stylesin.inputContainer}>
                <TextInput
                  label="Company Pincode"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={stylesin.input}
                />
                {errors.Company_Pincode && <Text style={styles.errorText}>{errors.Company_Pincode.message}</Text>}
              </View>
            )}
          />
        </View>

        {/* Company Phone Number */}
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
                style={stylesx.input}
              />
              {errors.phoneNumber && <Text style={styles.errorText}>{errors.phoneNumber.message}</Text>}
            </View>
          )}
        />

        {/* Company Email */}
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
                style={stylesx.input}
              />
              {errors.Company_Email && <Text style={styles.errorText}>{errors.Company_Email.message}</Text>}
            </View>
          )}
        />
        
        {/* Company GST No */}
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
                style={stylesx.input}
              />
              {errors.Company_GST && <Text style={styles.errorText}>{errors.Company_GST.message}</Text>}
            </View>
          )}
        />

        {/* Company CIN No */}
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
                style={stylesx.input}
              />
              {errors.Company_CIN && <Text style={styles.errorText}>{errors.Company_CIN.message}</Text>}
            </View>
          )}
        />

        {/* Company Udyam No */}
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
                style={stylesx.input}
              />
              {errors.Company_Udyam && <Text style={styles.errorText}>{errors.Company_Udyam.message}</Text>}
            </View>
          )}
        />

        {/* Submit Button */}
        <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)}>
          <Text style={styles.buttonText}>SUBMIT</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
};

// Styles remain unchanged
const styles = {
  input: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 10,
    margin: 5,
    borderRadius: 5,
    backgroundColor: 'white',
  },
  picker: {
    borderWidth: 1,
    borderColor: 'black',
    padding: 1,
    margin: 2,
    borderRadius: 10,
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
};

// Other styles remain unchanged
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

const stylesthreefield = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between'
  },
  input: {
    flex: 1,
    borderRadius: 8,
    paddingVertical: 0,
    paddingHorizontal: 0,
    margin: 0,
    height: 40,
    fontSize: 10,
    minWidth: 100,
    maxWidth: "33%",
  },
});

export default EnployMaster;