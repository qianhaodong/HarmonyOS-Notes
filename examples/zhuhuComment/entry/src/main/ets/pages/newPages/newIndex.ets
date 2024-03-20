import {
  HmNavBar,
  HmCommentItem,
  HmReplyInput,
} from './components/index';
import { ReplyItemModel } from './models/index';

@Entry
@Component
struct NewIndex {
  title: string = 'Hello World';
  scroller: Scroller = new Scroller();

  @State authorItem: ReplyItemModel = new ReplyItemModel({
    id: 999,
    avatar: $r('app.media.author'),
    author: '奔跑的蜗牛',
    content: 'HarmonyOS的创新体验将帮助您应对万物互联时代带来的挑战与机遇，结合覆盖应用生命周期的场景解决方案，打造受用户喜爱的应用。',
    time: '03-06',
    area: '深圳',
    likeNum: 99,
    likeFlag: true
  });
  // mock数据
  @State commentList: ReplyItemModel[] = [
    new ReplyItemModel({
      id: 1,
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      author: '偏执狂-妄想家',
      content: '更何况还分到一个摩洛哥[惊喜]',
      time: '11-30',
      area: '海南',
      likeNum: 34,
      likeFlag: false
    }) ,
    new ReplyItemModel({
      id: 2,
      avatar: 'https://pic1.zhimg.com/v2-5a3f5190369ae59c12bee33abfe0c5cc_xl.jpg?source=32738c0c',
      author: 'William',
      content: '当年希腊可是把1：0发挥到极致了',
      time: '11-29',
      area: '北京',
      likeNum: 58,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 3,
      avatar: 'https://picx.zhimg.com/v2-e6f4605c16e4378572a96dad7eaaf2b0_l.jpg?source=06d4cd63',
      author: 'Andy Garcia',
      content: '欧洲杯其实16队球队打正赛已经差不多，24队打正赛意味着正赛阶段在小组赛一样有弱队。',
      time: '11-28',
      area: '上海',
      likeNum: 10,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 4,
      avatar: 'https://picx.zhimg.com/v2-53e7cf84228e26f419d924c2bf8d5d70_l.jpg?source=06d4cd63',
      author: '正宗好鱼头',
      content: '确实眼红啊，亚洲就没这种球队，让中国队刷',
      time: '11-27',
      area: '香港',
      likeNum: 139,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 5,
      avatar: 'https://pic1.zhimg.com/v2-eeddfaae049df2a407ff37540894c8ce_l.jpg?source=06d4cd63',
      author: '柱子哥',
      content: '我是支持扩大的，亚洲杯欧洲杯扩到32队，世界杯扩到64队才是好的，世界上有超过200支队伍，欧洲区55支队伍，亚洲区47支队伍，即使如此也就六成出现率',
      time: '11-27',
      area: '旧金山',
      likeNum: 29,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 6,
      avatar: 'https://picx.zhimg.com/v2-fab3da929232ae911e92bf8137d11f3a_l.jpg?source=06d4cd63',
      author: '飞轩逸',
      content: '禁止欧洲杯扩军之前，应该先禁止世界杯扩军，或者至少把亚洲名额一半给欧洲。',
      time: '11-26',
      area: '里约',
      likeNum: 100,
      likeFlag: false
    })
  ];

  // 添加评论方法
  addComment(content: string) {
    this.commentList.unshift(new ReplyItemModel({
      id: Math.random(),
      avatar: $r('app.media.2'),
      author: '韭菜的春天',
      content,
      time: `${(new Date().getMonth() + 1).toString().padStart(2, '0')}-${(new Date().getDate()).toString().padStart(2, '0')}`,
      area: '深圳',
      likeNum: 0,
      likeFlag: false
    }));

    // 添加评论后，滚动到列表顶部
    // this.scroller.scrollEdge(Edge.Top);
    this.scroller.scrollTo({
      xOffset: 0,
      yOffset: 0,
      animation: true
    })
  }

  build() {
    Column() {
      // 顶部评论
      Row() {
        Column() {
          HmNavBar({ title: this.title })
          HmCommentItem({
            replyItem: this.authorItem,
          })
          .padding({ top: 20, bottom: 20 })
        }
        .width('100%')
      }
      .border({
        color: '#f4f5f6',
        width: {
          bottom: 10
        }
      })

      // 评论列表
      Column() {
        Text('评论列表')
          .padding(20)

        // 使用List组件（可滚动，有回弹效果）
        List({ scroller: this.scroller }) {
          ForEach(this.commentList, (item: ReplyItemModel) => {
            ListItem() {
              HmCommentItem({
                replyItem: item,
              })
            }
            .padding({ bottom: 20 })
          })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 底部回复
      HmReplyInput({
        publishComment: (content: string) => {
          this.addComment(content);
        }
      })
    }
    .height('100%')
  }
}