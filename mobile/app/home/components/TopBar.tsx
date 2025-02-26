import { View, Text, StyleSheet } from 'react-native';

export default function TopBar() {
  return (
    <View style={styles.topBar}>
      <Text style={styles.title}>My App</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  topBar: {
    height: 50,
    backgroundColor: '#6200ee',
    justifyContent: 'center',
    alignItems: 'center',
  },
  title: { color: 'white', fontSize: 18 },
});
