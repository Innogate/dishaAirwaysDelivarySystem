import { Stack } from 'expo-router';
import TopBar from './components/TopBar';
import BottomNav from './components/BottomNav';
import { View, StyleSheet } from 'react-native';

export default function Layout() {
  return (
    <View style={styles.container}>
      {/* Top Navigation Bar */}
      <TopBar />

      {/* Page Content (Acts like <router-outlet>) */}
      <View style={styles.content}>
        <Stack screenOptions={{ headerShown: false }} />
      </View>

      {/* Bottom Navigation Bar */}
      <BottomNav />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  content: { flex: 1 },
});
