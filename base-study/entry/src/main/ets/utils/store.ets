import preferences from '@ohos.data.preferences';

export const TOKEN = 'TOKEN';

export class StoreManager {
  static getStore(context?: Context) {
    const store = preferences.getPreferencesSync(context || getContext(), { name: 'store' });
    return store;
  }

  static async setToken(token: string) {
    console.log('setToken: ', token);
    const store = StoreManager.getStore();
    store.putSync(TOKEN, token);
    // 写入磁盘
    await store.flush();
  }

  static getToken(context?: Context) {
    const store = StoreManager.getStore(context);
    const token = store.getSync(TOKEN, '');
    console.log('getToken: ', token);
    return token;
  }
}