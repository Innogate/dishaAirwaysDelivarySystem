import { Stack } from 'expo-router';
import TopBar from './components/TopBar';
import BottomNav from './components/BottomNav';
import { View, StyleSheet } from 'react-native';

export default function Layout() {
  const pathSegments = window.location.pathname.split('/');
  const lastSegment = pathSegments[pathSegments.length - 1] || pathSegments[pathSegments.length - 2];

  function buttomNave() {
    if (lastSegment === 'login') {
      return;
    }
    return (<BottomNav />);
  }

  function topBar() {
    if (lastSegment === 'login') {
      return;
    }
    return (<TopBar />);
  }
  

  return (
    <View style={styles.container}>

      {topBar()}

      {/* Page Content (Acts like <router-outlet>) */}
      <View style={styles.content}>
        <Stack screenOptions={{ headerShown: false }} />
      </View>

      {buttomNave()}
      
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  content: { flex: 1 },
});
