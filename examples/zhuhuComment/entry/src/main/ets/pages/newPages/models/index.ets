export interface ReplyItem {
  avatar: ResourceStr // 头像
  author: string // 作者
  id: number
  content: string // 评论内容
  time: string // 时间
  area: string // 区域
  likeNum: number // 点赞数量
  likeFlag: Boolean | null // 用户是否点过赞
}

@Observed
export class ReplyItemModel implements ReplyItem {
  avatar: ResourceStr = ''
  author: string = ''
  id: number = 0
  content: string = ''
  time: string = ''
  area: string = ''
  likeNum: number = 0
  likeFlag: Boolean | null = null

  constructor(model: ReplyItem) {
    this.avatar = model.avatar
    this.author = model.author
    this.id = model.id
    this.content = model.content
    this.time = model.time
    this.area = model.area
    this.likeNum = model.likeNum
    this.likeFlag = model.likeFlag
  }
}
