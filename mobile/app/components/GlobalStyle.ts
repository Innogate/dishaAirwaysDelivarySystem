// styles.js
import { StyleSheet, Dimensions } from 'react-native';

const screenHeight = Dimensions.get("window").height;

const styles = StyleSheet.create({
  input: {
    borderRadius: 8,
    height: 50,
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

  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  twoinputContainer: {
    flex: 1,
    minWidth: "45%", // Ensures proper spacing
    maxWidth: "50%",
  },
  twoinput: {
    borderRadius: 8,
    height: 40,
    fontSize: 12,
  },

  // style for two picker input
  pickerContainer: {
    padding: 8,
  },
  rowContainer: {
    flexDirection: 'row', 
    justifyContent: 'space-between', 
    alignItems: 'center',
    marginTop: 8,
  },
  pickerWrapper: {
    flex: 1, 
    borderWidth: 1, 
    borderColor: '#ccc', 
    borderRadius: 8, 
    overflow: 'hidden', 

    backgroundColor: '#fff', 
    paddingHorizontal: 2, // Add some padding inside the picker
  },
  pickerWrapperLeft: {
    marginRight: 10, // Provides gap between the two pickers
  },
  picker: {
    height: 50, 
    color: '#333', 
  }, 
  iconContainer: {
    flexDirection: 'row',
    gap: 10,
  },
});



export default styles;