import media from '@ohos.multimedia.media';
import { PlayStateType, SongItemType } from '../models';
import { BusinessError, emitter } from '@kit.BasicServicesKit';
import { EmitEventType } from '../constants/EventConstants';
import { router } from '@kit.ArkUI';

export default class AVPlayerClass {
  // 1、创建一个播放器
  static player: media.AVPlayer | null = null

  // 播放状态
  static isPlay: boolean = false
  // 播放模式
  static playMode: 'auto' | 'repeat' | 'random' = 'auto'

  // 歌曲总时长
  static duration: number = 0
  // 歌曲播放进度时长
  static time: number = 0
  // 播放列表
  static playList: SongItemType[] = []
  // 当前播放歌曲索引
  static playIndex: number = 0

  // 2、初始化
  static async init() {
    AVPlayerClass.player = await media.createAVPlayer();

    // 监听播放器错误信息
    AVPlayerClass.player.on('error', (err: BusinessError) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
    })

    // 监听播放状态事件（状态机）
    AVPlayerClass.player.on('stateChange', (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'initialized':
          AVPlayerClass.player?.prepare();
          break;
        case 'prepared':
          AVPlayerClass.player?.play();
          AVPlayerClass.isPlay = true;
          break;
        case 'completed':
          // 判断是单曲循环
          if (AVPlayerClass.playMode === 'repeat') {
            AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex]);
          } else{
            AVPlayerClass.next();
          }
          break;
        default:
          break;
      }
    })

    // 监听进度条事件，获取播放总时长
    AVPlayerClass.player.on('durationUpdate', (duration: number) => {
      // console.log('[player]:durationUpdate >> ', duration)
      AVPlayerClass.duration = duration;
    })

    // 监听播放进度事件，获取当前播放进度
    AVPlayerClass.player.on('timeUpdate', (time: number) => {
      // console.log('[player]:durationUpdate >> ', time)
      AVPlayerClass.time = time;
      AVPlayerClass.updateState();
    })

    // 监听设置播放时长
    AVPlayerClass.player.on('seekDone', () => {
      AVPlayerClass.player?.play();
      AVPlayerClass.isPlay = true;
    })
  }

  // 单曲播放
  static singlePlay(song: SongItemType) {
    if (AVPlayerClass.player) {
      // 判断歌曲是否存在
      const cIndex = AVPlayerClass.playList.findIndex(item => item.id === song.id);
      if (cIndex !== -1) {
        // 判断是否是当前播放的
        if (song.url === AVPlayerClass.player.url) {
          // 是：判断是否正在播放
          if (AVPlayerClass.isPlay) {
            // 是：重新播放
            AVPlayerClass.changePlay();
          } else {
            // 否：继续播放（设置播放时长）
            AVPlayerClass.seekSlider(AVPlayerClass.time);
          }
        } else {
          // 否：切换歌曲（切换索引）
          AVPlayerClass.playIndex = cIndex;
          AVPlayerClass.changePlay()
        }
      } else {
        // 不存在，则添加到播放列表，并从头播放
        AVPlayerClass.playList.unshift(song);
        AVPlayerClass.playIndex = 0;
        AVPlayerClass.changePlay()
      }
    }
  }

  // 切换歌曲
  static async changePlay() {
    if (AVPlayerClass.player) {
      // 将播放器设置为闲置状态
      await AVPlayerClass.player.reset();

      // 重置播放时间
      AVPlayerClass.duration = 0;
      AVPlayerClass.time = 0;

      // 切歌
      AVPlayerClass.player.url = AVPlayerClass.playList[AVPlayerClass.playIndex].url;
    }
  }

  // 暂停
  static pausePlay() {
    if (AVPlayerClass.player) {
      AVPlayerClass.player.pause()
      AVPlayerClass.isPlay = false;
    }
  }

  // 上一首
  static prev() {
    if (AVPlayerClass.player) {
      if (!AVPlayerClass.playList.length) return;

      // 判断播放模式
      if (AVPlayerClass.playMode === 'random' && AVPlayerClass.playList.length > 1) {
        // 随机播放
        const len = AVPlayerClass.playList.length;
        let index = 0;

        // 妙啊
        do {
          index = Math.floor(Math.random() * len);
        } while (index === AVPlayerClass.playIndex)

        // 上面do-while循环结束后，则拿到非自身的索引
        AVPlayerClass.playIndex = index;
      } else {
        if (AVPlayerClass.playIndex === 0) {
          AVPlayerClass.playIndex = AVPlayerClass.playList.length - 1;
        } else if (AVPlayerClass.playIndex > 0) {
          AVPlayerClass.playIndex--;
        }
      }
      AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex]);
    }
  }

  // 下一首
  static next() {
    if (AVPlayerClass.player) {
      if (!AVPlayerClass.playList.length) return;

      // 判断播放模式
      if (AVPlayerClass.playMode === 'random' && AVPlayerClass.playList.length > 1) {
        const len = AVPlayerClass.playList.length;
        let index = 0;
        do {
          index = Math.floor(Math.random() * len);
        } while (index === AVPlayerClass.playIndex)

        // 上面do-while循环结束后，则拿到非自身的索引
        AVPlayerClass.playIndex = index;
      } else {
        if (AVPlayerClass.playIndex === AVPlayerClass.playList.length - 1) {
          AVPlayerClass.playIndex = 0;
        } else if (AVPlayerClass.playIndex < AVPlayerClass.playList.length - 1) {
          AVPlayerClass.playIndex++;
        }
      }
      AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex]);
    }
  }

  // 改变进度
  static seekSlider(time: number) {
    if (AVPlayerClass.player) {
      AVPlayerClass.player.seek(time);
    }
  }

  // 改变播放模式
  static changeMode(mode: 'auto' | 'repeat' | 'random') {
    AVPlayerClass.playMode = mode;
    AVPlayerClass.updateState();
  }

  // 删除播放列表歌曲
  static async delPlayItem(id: string) {
    const index = AVPlayerClass.playList.findIndex((item: SongItemType) => item.id === id);
    if (index !== -1) {
      console.log('AVPlayerClass-delPlayItem: ', index)
      // 删除歌曲
      AVPlayerClass.playList.splice(index, 1);

      // 判断是否是播放中歌曲
      if (AVPlayerClass.playIndex === index) {
        // 判断是播放中歌曲
        // 判断删除完后，是否还有歌曲
        if (AVPlayerClass.playList.length) {
          // 判断还有歌曲，则播放当前索引歌曲，如果当前歌曲是最后一首，则播放最后一首
          if (AVPlayerClass.playIndex > AVPlayerClass.playList.length - 1) {
            AVPlayerClass.playIndex = AVPlayerClass.playList.length - 1;
          }
          AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex]);
        } else {
          // 判断没有歌曲了
          // 重置播放器状态
          await AVPlayerClass.player?.reset();

          // 返回上一级页面
          router.back()
        }
      } else {
        // 判断不是播放中歌曲
        // 判断是删除播放歌曲前面的歌曲
        if (index < AVPlayerClass.playIndex) {
          // 删除后，当前播放索引-1
          AVPlayerClass.playIndex--;
        }
      }

      // 更新页面状态
      AVPlayerClass.updateState();
    }
  }

  // 更新页面状态
  static updateState() {
    // 发布事件，传递数据到各页面
    const currentItem = AVPlayerClass.playList[AVPlayerClass.playIndex];
    emitter.emit({ eventId: EmitEventType.UPDATE_STATE }, {
      data: {
        playState: {
          img: currentItem?.img || '',
          name: currentItem?.name || '',
          author: currentItem?.author || '',
          url: currentItem?.url || '',
          time: AVPlayerClass.time,
          duration: AVPlayerClass.duration,
          isPlay: AVPlayerClass.isPlay,
          playMode: AVPlayerClass.playMode,
          playIndex: AVPlayerClass.playIndex,
          playList: AVPlayerClass.playList,
        } as PlayStateType
      }
    });
  }
}