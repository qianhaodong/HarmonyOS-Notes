//声明飞机对象
/*
 * bf:飞机的血量
 * ,x：飞机的x轴坐标
 * ,y：飞机的y轴坐标
 * ,sizex:飞机的尺寸x 宽度
 * ,sizey：飞机的尺寸y 高度
 * ,speed：飞机的速度
 * ,score：飞机的分数
 * ,dietime：飞机的死亡时间
 * ,imgboomsrc：飞机爆炸图片地址
 * ,imgsrc：飞机的原始图片
 *
 */
export interface Plan {
  planBf: number
  planX: number
  planY: number
  planSizeX: number
  planSizeY: number
  planSpeed: number
  planScore: number
  planDieTime: number
  planIsDie?: Boolean
  planImgBoomSrc: ResourceStr
  planImgSrc: ResourceStr
  // planObj?: PlanObj
}

/*export interface PlanObj {
  left: number
  top: number
  src: ResourceStr
}*/

export class PlanModel implements Plan {
  planBf: number = 0
  planX: number = 0
  planY: number = 0
  planSizeX: number = 0
  planSizeY: number = 0
  planSpeed: number = 0
  planScore: number = 0
  planDieTime: number = 0
  planIsDie: Boolean = false
  planImgBoomSrc: ResourceStr = ''
  planImgSrc: ResourceStr = ''
  /*planObj: PlanObj = {
    left: 0,
    top: 0,
    src: ''
  }*/

  constructor(model: Plan) {
    this.planBf = model.planBf
    this.planX = model.planX
    this.planY = model.planY
    this.planSizeX = model.planSizeX
    this.planSizeY = model.planSizeY
    this.planSpeed = model.planSpeed
    this.planScore = model.planScore
    this.planDieTime = model.planDieTime
    this.planImgBoomSrc = model.planImgBoomSrc
    this.planImgSrc = model.planImgSrc
  }

  // 飞机移动方法
  planMove() {
    this.planY = this.planY + this.planSpeed * 2;
  }

  // 初始化飞机
  /*init() {
    console.log('init')
    this.planObj.left = this.planX;
    this.planObj.top = this.planY;
    this.planObj.src = this.planImgSrc;
  }*/
}
