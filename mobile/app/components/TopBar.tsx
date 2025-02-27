import { View, Text, StyleSheet } from 'react-native';
import globalStorage from './GlobalStorage';
export default function TopBar() {
  let title = globalStorage.getValue('pageTitle');
  return (
    <View style={styles.topBar}>
      <Text style={styles.title}>{title}</Text>
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
