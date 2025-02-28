import React, { useState, useRef } from "react";
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

// Validation Schema
const schema = yup.object().shape({
  States_Name: yup.string().required("States Name is required"),
});

const screenHeight = Dimensions.get("window").height;

const StatesMaster = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const slideAnim = useRef(new Animated.Value(screenHeight)).current;
  const startY = useRef(0);
  const [branches, setBranches] = useState([
    { id: 1, States_Name: "ABC Corp" },
  ]);
  const [selectedBranch, setSelectedBranch] = useState(null);
  const { control, handleSubmit, setValue, reset, formState: { errors } } = useForm({
    resolver: yupResolver(schema),
  });

  // Open Modal for Add / Edit
  const openModal = (branch = null) => {
    setSelectedBranch(branch);
    slideAnim.setValue(screenHeight);
    setModalVisible(true);
    if (branch) setValue("States_Name", branch.States_Name);
    
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
      setSelectedBranch(null);
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

  // Submit Form (Add / Edit)
  const onSubmit = (data) => {
    if (selectedBranch) {
      setBranches(
        branches.map((branch) =>
          branch.id === selectedBranch.id ? { ...branch, States_Name: data.States_Name } : branch
        )
      );
      Alert.alert("Updated!", "State updated successfully.");
    } else {
      const newBranch = { id: Date.now(), ...data };
      setBranches([...branches, newBranch]);
      Alert.alert("Added!", "New state added successfully.");
    }
    closeModal();
  };

  // Delete State
  const deleteBranch = (id) => {
    Alert.alert(
      "Confirm Delete",
      "Are you sure you want to delete this state?",
      [
        { text: "Cancel", style: "cancel" },
        {
          text: "OK",
          onPress: () => {
            setBranches((prevBranches) =>
              prevBranches.filter((branch) => branch.id !== id)
            );
          },
        },
      ]
    );
  };

  const renderBranchItem = ({ item }) => (
    <TouchableOpacity onPress={() => setSelectedBranch(item)}>
      <View style={styles.branchItem}>
        <Text style={styles.branchTitle}>{item.States_Name}</Text>
        {selectedBranch?.id === item.id && (
          <View style={styles.iconContainer}>
            <TouchableOpacity onPress={() => openModal(item)}>
              <MaterialIcons name="edit" size={24} color="blue" />
            </TouchableOpacity>
            <TouchableOpacity onPress={() => deleteBranch(item.id)}>
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
        data={branches}
        renderItem={renderBranchItem}
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
                  <Text style={styles.buttonText}>{selectedBranch ? "UPDATE" : "ADD"}</Text>
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
  branchItem: {
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
  branchTitle: {
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