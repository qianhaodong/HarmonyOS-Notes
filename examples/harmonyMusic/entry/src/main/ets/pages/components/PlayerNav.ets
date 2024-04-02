import { PlayStateType, SongItemType } from '../../models'
import AVPlayerClass from '../../utils/AVPlayerClass'

@Component
struct PlayerNav {
  @Link playState: PlayStateType;

  build() {
    Row() {
      Row({ space: 10 }) {
        Image(this.playState.img)
          .width(40)
          .height(40)

        Column({ space: 2 }) {
          Text(this.playState.name)
            .fontSize(16)
            .fontColor('#eaeaea')
          Text(this.playState.author)
            .fontSize(12)
            .fontColor('#ffa49e9e')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)

      Row({ space: 16 }) {
        Image($r("app.media.ic_prev"))
          .width(20)
          .aspectRatio(1)
          .fillColor('#4cafc6')
          .onClick(() => {
            // 切换上一首
            AVPlayerClass.prev();
          })
        Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
          .fillColor('#4cafc6')
          .width(20)
          .onClick(() => {
            if (AVPlayerClass.isPlay) {
              AVPlayerClass.pausePlay();
            } else {
              AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex]);
            }
          })
        Image($r('app.media.ic_next'))
          .width(20)
          .aspectRatio(1)
          .fillColor('#4cafc6')
          .onClick(() => {
            // 切换下一首
            AVPlayerClass.next();
          })
      }
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#ff1c1c21')
  }
}

export { PlayerNav }