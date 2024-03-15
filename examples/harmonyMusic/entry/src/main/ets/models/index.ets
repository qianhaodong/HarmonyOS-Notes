export interface TabClass {
  title: string
  name: string
  icon: ResourceStr
}

export interface DailyRecommendType {
  img: ResourceStr
  title: string
  type: string
  topColor: ResourceColor
  bottomColor: ResourceColor
}

export interface RecommendListType {
  img: ResourceStr
  title: string
  count: string
}

export interface SongItemType {
  img: ResourceStr
  name: string
  author: string
  url: ResourceStr
  id: string
}