import React, { useState, useRef, useEffect, useCallback } from 'react';
import { View, Text, TouchableOpacity, Alert, ScrollView, StyleSheet, Animated, Modal, PanResponder, Dimensions, FlatList } from 'react-native';
import { TextInput, FAB } from 'react-native-paper';
import { useForm, Controller } from 'react-hook-form';
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { Picker } from "@react-native-picker/picker";
import { MaterialIcons } from '@expo/vector-icons';
import Constants from "expo-constants";
import globalStorage from '@/app/components/GlobalStorage';
const API_BASE_URL = Constants.expoConfig?.extra?.API_BASE_URL;

// Define the validation schema
const schema = yup.object().shape({
  States_Name: yup.string().required('State Name is required'),
  City_Name: yup.string().required('City Name is required'),
});

const screenHeight = Dimensions.get("window").height;

const CityMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(screenHeight)).current;
  const startY = useRef(0);
  const [cities, setCities] = useState([]);
  const [statesList, setStatesList] = useState([]);
  const [selectedCity, setSelectedCity] = useState(null); // Track selected city for editing
  const [token, setToken] = useState(null);



  const fetchToken = async () => {
    try {
      const storedToken = await globalStorage.getValue("token");
      if (storedToken) {
        setToken(storedToken);
      } else {
        Alert.alert("Error", "Authentication token is missing.");
      }
    } catch (error) {
      console.error("Error fetching token:", error);
      Alert.alert("Error", "An error occurred while fetching the token.");
    }
  };


  const getAllStates = async () => {
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
          const formattedStates = resJson.body.map(state => ({
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
    } else {
      Alert.alert("Error", "aaa Authentication token missing.");
    }
  };

  useEffect(() => {
    fetchToken();
    if (token) {
      getAllStates();
    }
  }, [token]); // Runs when `token` changes


  const openModal = (city = null) => {
    slideAnim.setValue(screenHeight);
    setModalVisible(true);
    if (city) {
      setSelectedCity(city);
      setValue("States_Name", city.state_id); // Assuming city has state_id
      setValue("City_Name", city.city_name); // Assuming city has city_name
    } else {
      reset();
      setSelectedCity(null);
    }
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
    }).start(() => {
      setModalVisible(false);
      reset(); // Reset form when modal closes
    });
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

  const { control, handleSubmit, reset, setValue, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  const onSubmit = async (data) => {
    const url = API_BASE_URL + '/master/cities/new';
    const header = {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    };
    const body = JSON.stringify({
      "state_id": data.States_Name,
      "city_name": data.City_Name,
    });

    try {
      const res = await fetch(url, {
        method: 'POST',
        headers: header,
        body: body,
      });
      const resJson = await res.json();
      if (res.status === 200) {
        Alert.alert("Success", resJson.message);
        getAllStates();
      } else {
        Alert.alert("Error", resJson.message || "Failed to Add city.");
      }
    } catch {
      Alert.alert("Error", "Server Error");
    }
    closeModal();
  };

  const deleteCity = (city) => {
    Alert.alert(
      'Delete City',
      'Are you sure you want to delete this city?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'OK', onPress: () => {
            setCities(cities.filter(item => item.id !== city.id)); // Use id for filtering
            Alert.alert('Deleted', 'City deleted successfully');
          }
        },
      ]
    );
  };

  const renderCityItem = ({ item }) => (
    <TouchableOpacity onPress={() => setSelectedCity(selectedCity?.id === item.id ? null : item)}>
      <View style={styles.branchItem}>
        <Text style={styles.branchText}>{item.city_name}</Text>
        {selectedCity?.id === item.id && (
          <View style={styles.iconContainer}>
            <TouchableOpacity onPress={() => openModal(item)}>
              <MaterialIcons name="edit" size={24} color="blue" />
            </TouchableOpacity>
            <TouchableOpacity onPress={() => deleteCity(item)}>
              <MaterialIcons name="delete" size={24} color="red" />
            </TouchableOpacity>
          </View>
        )}
      </View>
    </TouchableOpacity>
  );

  const handleStateChange = async (stateId) => {
    if (stateId) {
      if (token) {
        const url = `${API_BASE_URL}/master/cities/byStateId`;
        const header = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        };
        const body = JSON.stringify({ from: 0, state_id: stateId });
        try {
          const res = await fetch(url, { method: "POST", headers: header, body });
          const resJson = await res.json();
          if (res.status === 200) {
            const formattedCities = resJson.body.map(city => ({
              id: city.id,
              city_name: city.name,
              state_id: city.state_id, // Assuming city has state_id
            }));
            setCities(formattedCities);
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

  return (
    <View style={{ flex: 1 }}>
      <Controller
        control={control}
        name="States_Name"
        render={({ field: { onChange, value } }) => (
          <View className='border'>
            <Picker
              selectedValue={value}
              onValueChange={(selectedId) => {
                onChange(selectedId);  // Update form state
                handleStateChange(selectedId);  // Fetch cities for selected state
              }}
            >
              <Picker.Item label="Select a state" value="" />
              {statesList.map((state) => (
                <Picker.Item key={state.id} label={String(state.States_Name)} value={state.id} />
              ))}
            </Picker>
          </View>
        )}
      />

      <FlatList
        data={cities}
        renderItem={renderCityItem}
        keyExtractor={(item) => item.id.toString()} // Use id as key
        contentContainerStyle={styles.listContainer}
      />
      <FAB
        style={styles.fab}
        icon="plus"
        onPress={() => openModal()}
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
                  name="States_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <Picker selectedValue={value} onValueChange={onChange}>
                        <Picker.Item label="Select a state" value="" />
                        {statesList.map((state) => (
                          <Picker.Item key={state.id} label={state.States_Name} value={state.id} />
                        ))}
                      </Picker>
                      {errors.States_Name && <Text style={styles.errorText}>{errors.States_Name.message}</Text>}
                    </View>
                  )}
                />
                <Controller
                  control={control}
                  name="City_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="City Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.City_Name && <Text style={styles.errorText}>{errors.City_Name.message}</Text>}
                    </View>
                  )}
                />
                <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)}>
                  <Text style={styles.buttonText}>{selectedCity ? "Update" : "Add"}</Text>
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
    flex: 1,
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 10,
    margin: 5,
    borderRadius: 5,
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
  fab: {
    position: 'absolute',
    margin: 16,
    right: 4,
    bottom: 48,
  },
  modalContent: {
    height: screenHeight * 0.5,
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
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  branchText: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  iconContainer: {
    flexDirection: 'row',
    gap: 10,
  },
});

export default CityMaster;