import { PlayStateType } from '../models'

export enum EmitEventType {
  UPDATE_STATE
}

export const defaultPlayState: PlayStateType = {
  img: '',
  name: '',
  author: '',
  url: '',
  isPlay: false,
  time: 0,
  duration: 0,
  playMode: 'auto',
  playIndex: 0,
  playList: []
}