import React, { useState, useRef, useEffect } from "react";
import {
  View,
  Text,
  TouchableOpacity,
  Alert,
  ScrollView,
  StyleSheet,
  Animated,
  Modal,
  PanResponder,
  Dimensions,
  FlatList,
} from "react-native";
import { TextInput, FAB } from "react-native-paper";
import { useForm, Controller } from "react-hook-form";
import * as yup from "yup";
import { yupResolver } from "@hookform/resolvers/yup";
import { MaterialIcons } from "@expo/vector-icons";
import { API_BASE_URL } from "@/constants/api.url";
import { tokens } from "react-native-paper/lib/typescript/styles/themes/v3/tokens";
import globalStorage from "@/app/components/GlobalStorage";

// Validation Schema
const schema = yup.object().shape({
  States_Name: yup.string().required("States Name is required"),
});

const screenHeight = Dimensions.get("window").height;

const StatesMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(screenHeight)).current;
  const startY = useRef(0);
  const [States, setStates] = useState([]);
  const [selectedStates, setselectedStates] = useState(null);
  const { control, handleSubmit, setValue, reset, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  // Open Modal for Add / Edit
  const openModal = (States = null) => {
    setselectedStates(States);
    slideAnim.setValue(screenHeight);
    setModalVisible(true);
    if (States) setValue("States_Name", States.States_Name);
    
    Animated.timing(slideAnim, {
      toValue: 0,
      duration: 300,
      useNativeDriver: true,
    }).start();
  };

  // Close Modal
  const closeModal = () => {
    Animated.timing(slideAnim, {
      toValue: screenHeight,
      duration: 300,
      useNativeDriver: true,
    }).start(() => {
      setModalVisible(false);
      reset();
      setselectedStates(null);
    });
  };

  // Swipe to Close Modal
  const panResponder = PanResponder.create({
    onStartShouldSetPanResponder: () => true,
    onPanResponderGrant: (_, gestureState) => {
      startY.current = gestureState.y0;
    },
    onPanResponderRelease: (_, gestureState) => {
      if (gestureState.moveY - startY.current > 100) closeModal();
    },
  });

  // Get all states
  const getAllStates = async () => {
    const token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.hbVVVjR08wPKctvNOgbGBm8xE_VRDureVLHgOaHj8iI";
  
    if (token) {
      const url = API_BASE_URL + "/master/states";
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
          const formattedStates = resJson.body.map((state) => ({
            id: state.id,
            States_Name: state.name,
          }));
          setStates(formattedStates);
        } else {
          Alert.alert("Error", resJson.message || "Failed to fetch states.");
        }
      } catch (error) {
        Alert.alert("Error", "Server Error");
        console.error("Fetch error:", error);
      }
    }
  };
  
  

  useEffect(() => {
    getAllStates(); // Fetch data on page load
  }, []);


  // Submit Form (Add / Edit)
  const onSubmit = async (data:any) => {
    if (selectedStates) {
      console.log(selectedStates);
      Alert.alert("Updated!", "State updated successfully.");
    } else {

      const url = API_BASE_URL + '/master/states/new';
      // const token = globalStorage.getValue('token');
       const token = globalStorage.getValue("token");
      const header = {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}` 
        };
      const body = JSON.stringify({
        "state_name": data.States_Name
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
        } else if (res.status === 409){
          Alert.alert("Error", resJson.message);
        }else{
          Alert.alert("Error", "Failed to Add state.");
        }
      }catch{
          Alert.alert("Error", "Server Error");
      }
    }
    closeModal();
  };

  // Delete State
  const deleteStates = async (id:number) => {
    console.log(id);
    Alert.alert(
      "Confirm Delete",
      "Are you sure you want to delete this state?",
      [
        { text: "Cancel", style: "cancel" },
        {
          text: "OK",
          onPress: async () => {
             const token = globalStorage.getValue("token");
            if (token) {
              const url = API_BASE_URL + '/master/states/delete';
              const headers = {
                "Content-Type": "application/json",
                Authorization: `Bearer ${token}`,
              };
              const body = JSON.stringify({
                "state_id": id
              });

  
              try {
                const response = await fetch(url, {
                  method: "POST",
                  headers: headers,
                  body: body,
                });
  
                const resJson = await response.json();
                console.log("Delete Response:", resJson);
  
                if (response.status === 200 && resJson.error_code === 0) {
                  // Remove deleted state from UI
                  setStates((prevStates) =>
                    prevStates.filter((state) => state.id !== id)
                  );
                  Alert.alert("Success", "State deleted successfully!");
                } else {
                  Alert.alert("Error", resJson.message || "Failed to delete state.");
                }
              } catch (error) {
                Alert.alert("Error", "Server Error");
                console.error("Delete error:", error);
              }
            }
          },
        },
      ]
    );
  };
  

  const renderStatesItem = ({ item }) => (
    <TouchableOpacity onPress={() => setselectedStates(item)}>
      <View style={styles.StatesItem}>
        <Text style={styles.StatesTitle}>{item.States_Name}</Text>
        {selectedStates?.id === item.id && (
          <View style={styles.iconContainer}>
            <TouchableOpacity onPress={() => openModal(item)}>
              <MaterialIcons name="edit" size={24} color="blue" />
            </TouchableOpacity>
            <TouchableOpacity onPress={() => deleteStates(item.id)}>
              <MaterialIcons name="delete" size={24} color="red" />
            </TouchableOpacity>
          </View>
        )}
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={{ flex: 1 }}>
      <FlatList
        data={States}
        renderItem={renderStatesItem}
        keyExtractor={(item) => item.id.toString()}
        contentContainerStyle={styles.listContainer}
      />

      <FAB style={styles.fab} icon="plus" onPress={() => openModal()} />

      {/* Modal */}
      <Modal transparent visible={modalVisible} animationType="none">
        <View style={styles.modalContainer}>
          <Animated.View {...panResponder.panHandlers} style={[styles.modalContent, { transform: [{ translateY: slideAnim }] }]}>
            <ScrollView contentContainerStyle={styles.modalScrollView} keyboardShouldPersistTaps="handled">
              <View>
                <Controller
                  control={control}
                  name="States_Name"
                  render={({ field: { onChange, value } }) => (
                    <View>
                      <TextInput
                        label="State Name"
                        mode="outlined"
                        value={value}
                        onChangeText={onChange}
                        style={styles.input}
                      />
                      {errors.States_Name && <Text style={styles.errorText}>{errors.States_Name.message}</Text>}
                    </View>
                  )}
                />
                <TouchableOpacity style={styles.button} onPress={handleSubmit(onSubmit)}>
                  <Text style={styles.buttonText}>{selectedStates ? "UPDATE" : "ADD"}</Text>
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
  fab: {
    position: "absolute",
    margin: 16,
    right: 4,
    bottom: 48,
  },
  modalContainer: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  modalContent: {
    height: screenHeight * 0.4,
    backgroundColor: "white",
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 20,
    width: "100%",
  },
  modalScrollView: {
    flexGrow: 1,
    paddingBottom: 80,
    minHeight: screenHeight * 0.6,
  },
  input: {
    backgroundColor: "white",
  },
  button: {
    backgroundColor: "#009688",
    padding: 15,
    borderRadius: 5,
    marginTop: 10,
    alignItems: "center",
  },
  buttonText: {
    color: "white",
    fontWeight: "bold",
  },
  errorText: {
    color: "red",
    fontSize: 12,
    marginTop: 5,
  },
  listContainer: {
    padding: 16,
  },
  StatesItem: {
    backgroundColor: "#fff",
    padding: 15,
    marginVertical: 10,
    borderRadius: 10,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    borderColor: "#ddd",
    borderWidth: 1,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  StatesTitle: {
    fontSize: 18,
    fontWeight: "bold",
    color: "#333",
  },
  iconContainer: {
    flexDirection: "row",
    gap: 10,
  },
});

export default StatesMaster;