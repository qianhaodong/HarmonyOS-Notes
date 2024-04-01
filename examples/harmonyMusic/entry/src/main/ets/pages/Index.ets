import { tabData } from '../constants';
import { PlayStateType, TabClass } from '../models';
import { Recommend } from './components/Recommend';
import { Find } from './components/Find';
import { Home } from './components/Home';
import { Moment } from './components/Moment';
import { Mine } from './components/Mine';
import { PlayerNav } from './components/PlayerNav';
import { router } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';
import { EmitEventType, defaultPlayState } from '../constants/EventConstants';

@Entry
@Component
struct Index {
  @State currentName: string = 'recommend';
  @State playing: Boolean = false;
  @State playState: PlayStateType = defaultPlayState;
  @Builder TabBuilder(item: TabClass) {
    Column() {
      Row() {
        Image(item.icon)
          .width(this.currentName === item.name ? 18 : 22)
          .aspectRatio(1)
          .fillColor(this.currentName === item.name ? Color.White : $r('app.color.primary_dark'))
      }
      .width(22)
      .aspectRatio(1)
      .backgroundColor(this.currentName === item.name ? $r('app.color.primary_light') : Color.Transparent)
      .borderRadius(22)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(item.title)
        .fontSize(12)
        .fontColor(this.currentName === item.name ? $r('app.color.primary_light') : $r('app.color.primary_dark'))
        .margin({ top: 5 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
  }

  aboutToAppear(): void {
    emitter.on({ eventId: EmitEventType.UPDATE_STATE }, (data) => {
      this.playState = data.data?.playState;
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End
    }) {
      ForEach(tabData, (item: TabClass) => {
        TabContent() {
          Column() {
            Column() {
              if (item.name === 'recommend') {
                Recommend()
              } else if (item.name === 'find') {
                Find()
              } else if (item.name === 'home') {
                Home()
              } else if (item.name === 'moment') {
                Moment()
              } else if (item.name === 'mine') {
                Mine()
              }
            }
            .layoutWeight(1)
            .backgroundColor('#000')

            // 播放器
            if (this.playState.playList.length) {
              PlayerNav({ playState: this.playState })
                .onClick(() => {
                  console.log('PlayerNav-click')
                  router.pushUrl({
                    url: 'pages/Play'
                  })
                })
            }
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#fff')
        }
        .tabBar(this.TabBuilder(item))
        .backgroundColor('#121215')
      })
    }
    .barHeight(60)
    .barBackgroundColor('#3c3f41')
    // .scrollable(false)
    .onTabBarClick((index) => {
      this.currentName = tabData[index].name;
    })
    .onAnimationEnd((index) => {
      this.currentName = tabData[index].name;
    })
  }
}