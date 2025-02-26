import { Stack } from 'expo-router';
import { View, StyleSheet } from 'react-native';

export default function Layout() {
  return (
      <View style={styles.content}>
        <Stack screenOptions={{ headerShown: false }} />
      </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  content: { flex: 1 },
});
