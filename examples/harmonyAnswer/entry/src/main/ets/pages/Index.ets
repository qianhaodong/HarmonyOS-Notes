import { HomeContent } from './components/homeContent';
import { MineContent } from './components/mineContent';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  tabController: TabsController = new TabsController();
  title: string = '欢迎使用鸿蒙刷题';

  @Builder TabBuilder(title: string, index: number, icon: Resource, iconActive: Resource) {
    Column() {
      Image(this.currentIndex === index ? iconActive : icon)
        .width(30)
        .height(30)
      Text(title)
        .fontColor(this.currentIndex === index ? '#1698CE' : '#6B6B6B')
    }
    .onClick(() => {
      // 直接改index，没有切换动效
      this.currentIndex = index;

      // 使用切换动效
      // this.tabController.changeIndex(index);
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      index: this.currentIndex,
      controller: this.tabController
    }) {
      TabContent() {
        HomeContent()
      }
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F5F7F9')
      .tabBar(this.TabBuilder('首页', 0, $r('app.media.ic_home'), $r('app.media.ic_home_actived')))

      TabContent() {
        Text('练习的内容')
      }
      .backgroundColor('#F5F5F5')
      .tabBar(this.TabBuilder('练习', 1, $r('app.media.ic_practice'), $r('app.media.ic_practice_actived')))

      TabContent() {
        MineContent()
      }
      .backgroundColor('#F5F5F5')
      .tabBar(this.TabBuilder('我的', 2, $r('app.media.ic_mine'), $r('app.media.ic_mine_actived')))
    }
    .scrollable(false)
  }
}