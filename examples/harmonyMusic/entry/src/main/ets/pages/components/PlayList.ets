import { PlayStateType, SongItemType } from '../../models'
import AVPlayerClass from '../../utils/AVPlayerClass'
import { emitter } from '@kit.BasicServicesKit';
import { EmitEventType } from '../../constants/EventConstants';
import { StoreManager } from '../../utils/Store';

@Extend(Text) function textStyle() {
  .width(20)
  .margin({ right: 20 })
  .textAlign(TextAlign.Center)
}

@Component
struct PlayList {
  @Prop deletable: boolean = false;
  @Link playList: SongItemType[];

  @State playId: string = '';

  @Builder MoreBuilder() {};
  @BuilderParam MoreBuilderParm: () => void = this.MoreBuilder;
  @Builder delButtonBuilder(id: string) {
    Button('删除')
      .width(80)
      .height('100%')
      .fontColor('#fff')
      .backgroundColor($r('app.color.primary_light'))
      .type(ButtonType.Normal)
      .onClick(() => {
        this.delPlayItem(id);
      })
  }

  emitClick: (index: number) => void = () => {}
  delPlayItem: (id: string) => void = () => {}

  aboutToAppear() {
    // 获取首选项数据
    const playState = StoreManager.getData();
    if (playState.playList.length) {
      this.playId = playState.playList[playState.playIndex].id;
    }

    emitter.on({ eventId: EmitEventType.UPDATE_STATE }, (data) => {
      const playState: PlayStateType = data.data?.playState;
      if (playState.playList.length) {
        this.playId = playState.playList[playState.playIndex].id;
      }
    })
  }

  build() {
    Column() {
      Row() {
        Row({ space: 8 }) {
          Image($r('app.media.ic_play'))
            .width(16)
            .fillColor('#ff5186')
          Text(`全部播放(${this.playList.length})`)
            .fontSize(14)
            .fontColor($r('app.color.color_white'))
        }
        .layoutWeight(1)

        this.MoreBuilderParm()
      }
      .width('100%')
      .margin({ bottom: 10 })

      List() {
        ForEach(this.playList, (item: SongItemType, index) => {
          ListItem() {
            Row() {
              if (index === 0) {
                Text(`${index + 1}`)
                  .textStyle()
                  .fontColor('#ffffe426')
                  .fontWeight(FontWeight.Bold)
              } else if (index === 1) {
                Text(`${index + 1}`)
                  .textStyle()
                  .fontColor($r('app.color.primary_light'))
                  .fontWeight(FontWeight.Bold)
              } else if (index === 2) {
                Text(`${index + 1}`)
                  .textStyle()
                  .fontColor($r('app.color.primary_dark'))
                  .fontWeight(FontWeight.Bold)
              } else {
                Text(`${index + 1}`)
                  .textStyle()
                  .fontColor('#ffa49e9e')
              }

              Image(item.img)
                .width(40)
                .borderRadius(8)

              Column({ space: 4 }) {
                Text(item.name)
                  .fontSize(14)
                  .fontColor(this.playId === item.id ? '#FFB54747' : '#ffa49e9e')
                Text(item.author)
                  .fontSize(12)
                  .fontColor(this.playId === item.id ? '#FFB54747' : '#ffa49e9e')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 10, right: 10 })

              Image($r('app.media.ic_more'))
                .width(24)
                .fillColor('#aaa9af')
            }
            .padding({ top: 10, bottom: index === this.playList.length - 1 ? 20 : 10 })
          }
          .swipeAction(this.deletable ? {
            end: this.delButtonBuilder(item.id)
          } : {})
          .border({
            width: { bottom: 1 },
            color: '#12ec5c87'
          })
          .onClick(() => {
            AVPlayerClass.singlePlay(item);
            this.emitClick(index);
          })
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding({ top: 16, right: 16, left: 16 })
    .backgroundColor('#ff353333')
    .borderRadius({
      topLeft: 12,
      topRight: 12,
    })
  }
}

export { PlayList }