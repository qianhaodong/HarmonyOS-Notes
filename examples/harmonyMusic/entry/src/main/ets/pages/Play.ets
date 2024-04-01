import { PlayStateType, SongItemType } from '../models';
import AVPlayerClass from '../utils/AVPlayerClass';
import { songs } from '../constants/index';
import { emitter } from '@kit.BasicServicesKit';
import { defaultPlayState, EmitEventType } from '../constants/EventConstants';

@Entry
@Component
struct Play {
  @State songs: SongItemType[] = AVPlayerClass.playList;
  @State playState: PlayStateType = defaultPlayState;

  aboutToAppear(): void {
    emitter.on({ eventId: EmitEventType.UPDATE_STATE }, (data) => {
      this.playState = data.data?.playState;
      // console.log('this.playState: ', this.playState)
    })
  }

  // 处理歌曲时间格式
  handleTime(duration: number): string {
    const totalSecond = Math.ceil(duration / 1000);
    let  minute: number | string = Math.floor(totalSecond / 60);
    let second: number | string = totalSecond % 60;
    minute = minute < 10 ? minute.toString().padStart(2, '0') : minute;
    second = second < 10 ? second.toString().padStart(2, '0') : second;
    return `${minute}:${second}`;
  }

  build() {
    Stack() {
      // 模糊背景
      Image(this.playState.img)
        .width('100%')
        .height('100%')
        .blur(1000)

      // 内容
      Column() {
        // 歌曲信息
        Column() {
          Stack({ alignContent: Alignment.Top }) {
            Row() {
              Row() {
                Image(this.playState.img)
                  .width('70%')
                  .borderRadius(400)
              }
              .backgroundImage($r('app.media.ic_cd'))
              .backgroundImageSize(ImageSize.Cover)
              .justifyContent(FlexAlign.Center)
              .width('100%')
              .borderRadius(400)
              .clip(true)
              .aspectRatio(1)
            }
            .margin({ top: 50 })
            .width('90%')
            .aspectRatio(1)
            .justifyContent(FlexAlign.Center)
            .padding(24)

            // 唱针
            Image($r('app.media.ic_stylus'))
              .width(200)
              .aspectRatio(1)
              .rotate({
                angle: -55,
                centerX: 100,
                centerY: 30
              })
              .animation({
                duration: 500
              })
          }

          Column({ space: 8 }) {
            Text(songs[0].name)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.primary_dark'))
            Text(songs[0].author)
              .fontSize(18)
              .fontColor($r('app.color.primary_dark'))
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          // .zIndex(1)
        }
        .layoutWeight(1)
        .width('100%')

        // 底部操作栏
        Column() {
          Row() {
            Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC', borderColor: Color.Transparent } }) {
              Image($r('app.media.ic_like'))
                .width(24)
                .fillColor(Color.White)
            }

            Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc', borderColor: Color.Transparent } }) {
              Image($r("app.media.ic_comment_o"))
                .fillColor(Color.White)
                .width(20)
            }

            Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131', borderColor: Color.Transparent } }) {
              Image($r("app.media.ic_bells_o"))
                .fillColor(Color.White)
                .width(24)
            }

            Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371', borderColor: Color.Transparent } }) {
              Image($r("app.media.ic_download_o"))
                .fillColor(Color.White)
                .width(24)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)

          // 进度条
          Row({ space: 8 }) {
            Text(this.handleTime(this.playState.time))
              .fontSize(12)
              .fontColor($r('app.color.color_white'))
            Slider({
              value: this.playState.time,
              min: 0,
              max: this.playState.duration
            })
              .layoutWeight(1)
              .trackColor('#e1e1e1')
              .selectedColor(Color.White)
            Text(this.handleTime(this.playState.duration))
              .fontSize(12)
              .fontColor($r('app.color.color_white'))
          }
          .width('100%')
          .padding(24)

          Row() {
            Row() {
              if (this.playState.playMode === 'auto') {
                Image($r('app.media.ic_auto'))
                  .fillColor(Color.White)
                  .width(30)
              } else if (this.playState.playMode === 'repeat') {
                Image($r('app.media.ic_repeat'))
                  .fillColor(Color.White)
                  .width(30)
              } else if (this.playState.playMode === 'random') {
                Image($r('app.media.ic_random'))
                  .fillColor(Color.White)
                  .width(30)
              }
            }
            .onClick(() => {
              if (this.playState.playMode === 'auto') {
                AVPlayerClass.playMode = 'repeat';
              } else if (this.playState.playMode === 'repeat') {
                AVPlayerClass.playMode = 'random';
              } else if (this.playState.playMode === 'random') {
                AVPlayerClass.playMode = 'auto';
              }
            })

            Image($r("app.media.ic_prev"))
              .fillColor(Color.White)
              .width(30)
              .onClick(() => {
                // 切换上一首
                AVPlayerClass.prev();
              })

            // 播放按钮
            // Image($r('app.media.ic_play'))
            Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
              .fillColor(Color.White)
              .width(50)
              .onClick(() => {
                if (AVPlayerClass.isPlay) {
                  AVPlayerClass.pausePlay();
                } else {
                  AVPlayerClass.continuePlay();
                }
              })

            // 下一首
            Image($r('app.media.ic_next'))
              .fillColor(Color.White)
              .width(30)
              .onClick(() => {
                // 切换下一首
                AVPlayerClass.next();
              })

            // 播放列表
            Image($r('app.media.ic_song_list'))
              .fillColor(Color.White)
              .width(30)
          }
          .width('100%')
          .padding({ bottom: 24 })
          .justifyContent(FlexAlign.SpaceAround)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }
}