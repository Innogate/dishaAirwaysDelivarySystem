import React from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet } from 'react-native';
import { TextInput } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import { Picker } from '@react-native-picker/picker';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';

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
  destination: yup.string().required('Destination is required'),
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

const BookingForm = () => {
  const { control, handleSubmit, setValue, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  interface FormData {
    bookingNo: string;
    consignor: string;
    phoneNumber: string;
    consignee: string;
    consigneePhoneNumber: string;
    destination: string;
    branch: string;
    transportType: string;
    packages: number;
    weight: number;
    declaredValue: number;
    totalValue: number;
    contain?: number;
    charges?: number;
    shipper?: number;
    igst?: number;
    sgst?: number;
    cgst?: number;
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
      {/* Booking No & Consignor */}
      <View className="gap-2">
        <View style={stylesin.container} className="gap-2">
          <Controller
            control={control}
            name="bookingNo"
            render={({ field: { onChange, onBlur, value } }) => (
              <View style={stylesin.inputContainer}>
                <TextInput
                  label="Booking No"
                  value={value}
                  mode="outlined"
                  keyboardType="numeric"
                  onBlur={onBlur}
                  onChangeText={onChange}
                  style={[stylesin.input]}
                />
                {errors.bookingNo && <Text style={styles.errorText}>{errors.bookingNo.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="consignor"
            render={({ field: { onChange, value } }) => (
              <View style={stylesin.inputContainer}>
                <TextInput
                  label="Consignor"
                  mode="outlined"
                  value={value}
                  onChangeText={onChange}
                  style={[stylesin.input]}
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
                style={stylesx.input}
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
                style={stylesx.input}
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
                style={stylesx.input}
              />
              {errors.consigneePhoneNumber && <Text style={styles.errorText}>{errors.consigneePhoneNumber.message}</Text>}
            </View>
          )}
        />
        {/* Destination & Branch */}
        <View style={stylesin.container} className="gap-2">
          <Controller
            control={control}
            name="destination"
            render={({ field: { onChange, value } }) => (
              <View style={stylesin.inputContainer}>
                <TextInput
                  label="Destination"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={stylesin.input}
                />
                {errors.destination && <Text style={styles.errorText}>{errors.destination.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="branch"
            render={({ field: { onChange, value } }) => (
              <View style={stylesin.inputContainer}>
                <TextInput
                  label="Destination Branch Name"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={stylesin.input}
                />
                {errors.branch && <Text style={styles.errorText}>{errors.branch.message}</Text>}
              </View>
            )}
          />
        </View>
        <Controller
          control={control}
          name="transportType"
          render={({ field: { onChange, value } }) => (
            <View>
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
        <View style={stylesthreefield.container} className="gap-2">
          <Controller
            control={control}
            name="packages"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput
                  label="No of Packages"
                  mode='outlined'
                  value={value}
                  onChangeText={onChange}
                  style={stylesthreefield.input}
                />
                {errors.packages && <Text style={styles.errorText}>{errors.packages.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="weight"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput
                  label="Weight"
                  mode='outlined'
                  keyboardType="numeric"
                  value={value}
                  onChangeText={onChange}
                  style={stylesthreefield.input}
                />
                {errors.weight && <Text style={styles.errorText}>{errors.weight.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="declaredValue"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput
                  label="Declared Value"
                  mode='outlined'
                  keyboardType="numeric"
                  value={value}
                  onChangeText={onChange}
                  style={stylesthreefield.input}
                />
                {errors.declaredValue && <Text style={styles.errorText}>{errors.declaredValue.message}</Text>}
              </View>
            )}
          />
        </View>

        <View style={stylesthreefield.container} className="gap-2">
          <Controller
            control={control}
            name="contain"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput label="Contain" mode='outlined' value={value} onChangeText={onChange} style={stylesthreefield.input} />
                {errors.contain && <Text style={styles.errorText}>{errors.contain.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="charges"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput label="Charges" mode='outlined' value={value} onChangeText={onChange} style={stylesthreefield.input} keyboardType="numeric" />
                {errors.charges && <Text style={styles.errorText}>{errors.charges.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="shipper"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput label="Shipper's" mode='outlined' value={value} onChangeText={onChange} style={stylesthreefield.input} keyboardType="numeric" />
                {errors.shipper && <Text style={styles.errorText}>{errors.shipper.message}</Text>}
              </View>
            )}
          />
        </View>

        {/* Taxes */}
        <View style={stylesthreefield.container} className="gap-2">
          <Controller
            control={control}
            name="cgst"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput label="CGST" mode='outlined' value={value} onChangeText={onChange} style={stylesthreefield.input} keyboardType="numeric" />
                {errors.cgst && <Text style={styles.errorText}>{errors.cgst.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="sgst"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput label="SGST" mode='outlined' value={value} onChangeText={onChange} style={stylesthreefield.input} keyboardType="numeric" />
                {errors.sgst && <Text style={styles.errorText}>{errors.sgst.message}</Text>}
              </View>
            )}
          />
          <Controller
            control={control}
            name="igst"
            render={({ field: { onChange, value } }) => (
              <View>
                <TextInput label="IGST" mode='outlined' value={value} onChangeText={onChange} style={stylesthreefield.input} keyboardType="numeric" />
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
                style={stylesx.input}
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

export default BookingForm;