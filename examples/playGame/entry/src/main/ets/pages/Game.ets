import { router } from '@kit.ArkUI';
import { Plan, PlanModel } from '../models';

@Builder function CreatePlan(sizeX: number, sizeY: number, src: ResourceStr) {
  Image(src)
    .width(sizeX)
    .height(sizeY)
}

@Extend(Button) function btnStyle() {
  .height(42)
  .width(200)
  .backgroundColor(Color.Gray)
  .fontColor(Color.Black)
  .fontSize(18)
  .border({
    color: Color.Black,
    width: 1
  })
}

@Entry
@Component
struct Game {
  @State backgroundY: number = 0;
  @State score: number = 0;
  @State gamePause: Boolean = false;

  // 获取当前屏幕的宽度（预览器不支持）
  // screenDisplay: display.Display = display.getDefaultDisplaySync();
  screenWidth: number = 360;
  screenHeight: number = 780;

  // 创建本方飞机
  @State ourPlan: PlanModel = new PlanModel({
    planBf: 1,
    planX: (this.screenWidth - 66) / 2,
    planY: 600,
    planSizeX: 66,
    planSizeY: 80,
    planSpeed: 0,
    planScore: 0,
    planDieTime: 600,
    // planIsDie: false,
    planImgBoomSrc: $r('app.media.bffjbx'),
    planImgSrc: $r('app.media.wdfj')
  });
  // 敌方飞机列表
  @State enemyPlanList: PlanModel[] = [];
  @State enemyPlan: PlanModel = this.createEnemyPlan(1, 324, -100, 34, 24, 3, 100, 200, $r('app.media.xfjbz'), $r('app.media.enemy1_fly_1'));

  // 定时器 timerId
  bgTimer: number = 0;
  gameStat() {
    // 定时器，让背景图片坐标自增
    console.log('[game]:开启定时器')
    this.bgTimer = setInterval(() => {
      this.gameMove();
    }, 40);
  }

  mark: number = 0;
  gameMove() {
    this.backgroundY += 6;

    // 敌方飞机移动
    this.enemyPlan.planMove();


    //
    this.mark++;
    if (this.mark % 150 === 0) {
      // 创建大型飞机
      const bigPlan = this.createEnemyPlan(3, 248, -100, 110, 164, 1, 300, 600, $r('app.media.dfjbz'), $r('app.media.enemy2_fly_1'));
      this.enemyPlanList.push(bigPlan);
    } else if (this.mark % 60 === 0) {
      // 创建中型飞机
      const middlePlan = this.createEnemyPlan(2, 312, -100, 46, 60, 2, 200, 400, $r('app.media.zfjbz'), $r('app.media.enemy3_fly_1'));
      this.enemyPlanList.push(middlePlan);
    } else if (this.mark % 20 === 0) {
      // 创建小型飞机
      const smallPlan = this.createEnemyPlan(1, 324, -100, 34, 24, 3, 100, 200, $r('app.media.xfjbz'), $r('app.media.enemy1_fly_1'));
      this.enemyPlanList.push(smallPlan);
    }

    // 让敌方飞机移动
    for (let i = 0; i < this.enemyPlanList.length; i++) {
      this.enemyPlanList[i].planMove();
    }
  }

  // 创建敌方飞机
  createEnemyPlan(
    bf: number,
    x: number,
    y: number,
    sizeX: number,
    sizeY: number,
    speed: number,
    score: number,
    dieTime: number,
    imgBoomSrc: ResourceStr,
    imgSrc: ResourceStr
  ): PlanModel {
    const enemyPlan: PlanModel = new PlanModel({
      planBf: bf,
      planX: this.createRandom(x),
      planY: y,
      planSizeX: sizeX,
      planSizeY: sizeY,
      planSpeed: speed,
      planScore: score,
      planDieTime: dieTime,
      planImgBoomSrc: imgBoomSrc,
      planImgSrc: imgSrc,
    });
    return enemyPlan;
  }

  // 生成随机数
  createRandom(a: number): number {
    return Math.floor(Math.random() * a);
  }

  // 销毁定时器
  handleClearInterval() {
    if (this.bgTimer) {
      console.log('[game]:销毁定时器')
      clearInterval(this.bgTimer);
      this.bgTimer = 0;
    }
  }

  // 组件生命周期钩子函数
  // 组件实例创建完成，执行build()函数之前调用
  aboutToAppear() {
    console.log('[game]:游戏开始')
    this.gameStat();
  }
  // 在组件销毁之前调用
  aboutToDisappear() {
    console.log('[game]:回到主页')
    this.handleClearInterval();
  }

  build() {
    Stack() {
      Column() {
        Stack() {
          // 敌方飞机出现区域
          Column() {
            /*Row() {
              CreatePlan(
                this.enemyPlan.planSizeX,
                this.enemyPlan.planSizeY,
                this.enemyPlan.planImgSrc
              )
            }
            // .backgroundColor('rgba(0,0,0,0.3)')
            .position({
              x: this.enemyPlan.planX,
              y: this.enemyPlan.planY,
            })*/
            ForEach(this.enemyPlanList, (item: PlanModel) => {
              Row() {
                CreatePlan(
                  item.planSizeX,
                  item.planSizeY,
                  item.planImgSrc
                )
              }
              // .backgroundColor('rgba(0,0,0,0.3)')
              .position({
                x: item.planX,
                y: item.planY,
              })
            })
          }

          Text(`分数：${this.score}`)
            .fontSize(20)
            .margin({ top: 20, left: 20 })

          // 本方飞机操作区域
          Column() {
            Row() {
              CreatePlan(
                this.ourPlan.planSizeX,
                this.ourPlan.planSizeY,
                this.ourPlan.planImgSrc
              )
            }
            // .backgroundColor('rgba(0,0,0,0.3)')
            .position({
              x: this.ourPlan.planX,
              y: this.ourPlan.planY,
            })
          }
          .width('100%')
          .height('100%')
          .onTouch((e: TouchEvent) => {
            const touchItem = e.touches[0];
            // console.log('touch')

            // 判断触摸点，在本方飞机区域内，则移动
            if (
              touchItem.x >= this.ourPlan.planX &&
              touchItem.x <= (this.ourPlan.planX + this.ourPlan.planSizeX) &&
              touchItem.y >= this.ourPlan.planY &&
              touchItem.y <= (this.ourPlan.planY + this.ourPlan.planSizeY)
            ) {
              let x = touchItem.x - this.ourPlan.planSizeX / 2;
              let y = touchItem.y - this.ourPlan.planSizeY / 2;
              // console.log('touch-x: ', x, 'touch-y: ', y);

              // 判断飞机移动到左右边缘
              if (x <= 0) {
                x = 0;
              } else if (x >= (this.screenWidth - this.ourPlan.planSizeX)) {
                x = this.screenWidth - this.ourPlan.planSizeX;
              }
              // 判断飞机移动到上下边缘
              if (y <= 0) {
                y = 0;
              } else if (y >= (this.screenHeight - this.ourPlan.planSizeY)) {
                y = this.screenHeight - this.ourPlan.planSizeY;
              }

              // 更新本方飞机位置
              this.ourPlan.planX = x;
              this.ourPlan.planY = y;
            }
          })
        }
        .width('100%')
        .height('100%')
        .alignContent(Alignment.TopStart)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .backgroundImage($r('app.media.background_1'), ImageRepeat.Y)
      .backgroundImageSize(ImageSize.Contain)
      .backgroundImagePosition({
        x: 0,
        y: this.backgroundY
      })
      .onClick(() => {
        // 暂停游戏
        console.log('[game]:游戏暂停')
        this.gamePause = true;
        this.handleClearInterval();
      })

      // 暂停弹窗
      Column({ space: 20 }) {
        Button('继续')
          .btnStyle()
          .onClick(() => {
            this.gameStat();
            this.gamePause = false;
          })
        /*Button('重新开始')
          .btnStyle()
          .onClick(() => {

          })*/
        Button('回到主页')
          .btnStyle()
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Index'
            })
          })
      }
      .visibility(this.gamePause ? Visibility.Visible : Visibility.Hidden)
      // .visibility(Visibility.Hidden)

      // 游戏结束弹窗
      Column() {
        Text('飞机大战分数')
          .width('100%')
          .height(48)
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .border({
            color: Color.Black,
            width: {
              bottom: 1
            }
          })
        Text('100')
          .width('100%')
          .height(48)
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .border({
            color: Color.Black,
            width: {
              bottom: 1
            }
          })
        Row() {
          Button('返回主页')
            .btnStyle()
            .height(36)
            .width(110)
            .fontSize(16)
        }
        .layoutWeight(1)
      }
      .height(170)
      .width(240)
      .backgroundColor('#eaeaea')
      .borderRadius(16)
      .border({
        color: Color.Black,
        width: 1
      })
      .visibility(Visibility.Hidden)
    }
    .width(this.screenWidth)
    .height(this.screenHeight)
  }
}