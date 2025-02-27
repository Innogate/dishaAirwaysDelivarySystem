import AsyncStorage from "@react-native-async-storage/async-storage";

class GlobalStorage {
  private tempStore: Record<string, any> = {};

  setTemp(key: string, value: any) {
    this.tempStore[key] = value;
  }

  async setPermanent(key: string, value: any) {
    await AsyncStorage.setItem(key, JSON.stringify(value));
  }

  async getValue(key: string): Promise<any> {
    if (key in this.tempStore) {
      return this.tempStore[key];
    }
    const storedValue = await AsyncStorage.getItem(key);
    return storedValue ? JSON.parse(storedValue) : null;
  }

  async delete(key: string) {
    delete this.tempStore[key];
    await AsyncStorage.removeItem(key);
  }

  async destroy() {
    this.tempStore = {};
    await AsyncStorage.clear();
  }
}

const globalStorage = new GlobalStorage();
globalStorage.setTemp("pageTitle","Login")
export default globalStorage;
