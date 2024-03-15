import { swiperList, dailyRecommend, recommendList } from '../../constants';
import { DailyRecommendType, RecommendListType } from '../../models';

@Component
struct SearchBox {
  build() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.ic_search'))
            .width(20)
            .aspectRatio(1)
            .fillColor('#7a828e')
          TextInput({ placeholder: '只因你太美🔥' })
            .fontColor('#f1f1f1')
            .placeholderColor('#7a828e')
            .layoutWeight(1)
            .height(48)
            .padding({ left: 4, right: 0})
        }
        .layoutWeight(1)
        .padding({ right: 20 })

        Image($r('app.media.ic_code'))
          .width(20)
          .height(20)
      }
      .width('100%')
      .height(44)
      .backgroundColor('#FF2D2A2A')
      .borderRadius(42)
      .padding({ left: 12, right: 12 })
    }
    .width('100%')
    .padding({ left: 16, right:16, top: 16 })
  }
}

@Component
struct Banner {
  build() {
    Column() {
      Swiper() {
        ForEach(swiperList, (item: string) => {
          Row() {
            Image(item)
              .width('100%')
          }
          .borderRadius(8)
          .clip(true)
        })
      }
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
    .margin({ top: 30, bottom: 30 })
  }
}

@Component
struct SectionBox {
  title: string = '';
  @Require @BuilderParam sectionBuilderParam: () => void;

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(18)
          .fontColor('#f1f1f1')
        Text('更多')
          .fontSize(16)
          .fontColor('#ff8c8888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 10 })

      this.sectionBuilderParam()
    }
    .width('100%')
    .padding({ left: 10, right: 10 })
    .margin({ bottom: 20 })
  }
}

@Component
struct Recommend {
  // scroller: Scroller = new Scroller();

  @Builder DailyRecommendBuilder() {
    Column() {
      Scroll() {
        Row({ space: 10 }) {
          ForEach(dailyRecommend, (item: DailyRecommendType) => {
            Column() {
              Text(item.type)
                .width('100%')
                .padding(8)
                .backgroundColor(item.topColor)
                .fontSize(12)
                .fontColor('#f1f1f1')
              Image(item.img)
                .width('100%')
              Text(item.title)
                .width('100%')
                .padding(8)
                .backgroundColor(item.bottomColor)
                .fontSize(10)
                .fontColor('#c2c3c4')
                .maxLines(2)
                .textOverflow({
                  overflow: TextOverflow.Ellipsis
                })
            }
            .width(130)
            .borderRadius(8)
            .clip(true)
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
    }
    .width('100%')
  }
  @Builder RecommendListBuilder() {
    Column() {
      Scroll() {
        Row({ space: 10 }) {
          ForEach(recommendList, (item: RecommendListType) => {
            Column({ space: 6 }) {
              Stack() {
                Image(item.img)
                Text(item.count)
                  .fontSize(10)
                  .fontColor('#fff')
                  .margin({ top: 6, left: 6 })
              }
              .alignContent(Alignment.TopStart)

              Text(item.title)
                .width('100%')
                .fontSize(10)
                .fontColor('#c2c3c4')
                .maxLines(2)
                .textOverflow({
                  overflow: TextOverflow.Ellipsis
                })
            }
            .width(100)
            .borderRadius(8)
            .clip(true)
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
    }
    .width('100%')
  }

  build() {
    Scroll() {
      Column() {
        // 搜索栏
        SearchBox()

        // banner广告
        Banner()

        // 每日推荐
        SectionBox({
          title: '每日推荐',
          sectionBuilderParam: this.DailyRecommendBuilder
        })

        // 推荐歌单
        SectionBox({
          title: '推荐歌单',
          sectionBuilderParam: this.RecommendListBuilder
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}

export { Recommend }