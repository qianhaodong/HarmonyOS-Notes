import { preferences } from '@kit.ArkData'
import { defaultPlayState } from '../constants/EventConstants';
import { PlayStateType } from '../models';

export const PLAYER_DATA = 'PLAYER_DATA';

export class StoreManager {
  static context: Context

  static getStore(context: Context = StoreManager.context) {
    const store = preferences.getPreferencesSync(context, { name: 'playerData' });
    return store;
  }

  static async setData(playState: PlayStateType) {
    const store = StoreManager.getStore();
    store.putSync(PLAYER_DATA, JSON.stringify(playState));
    await store.flush();
  }

  static getData(context?: Context) {
    const store = StoreManager.getStore(context);
    const data = store.getSync(PLAYER_DATA, JSON.stringify(defaultPlayState)) as string;
    const playState: PlayStateType = JSON.parse(data);
    return playState;
  }
}