@Component
struct HmReplyInput {
  @State
  inputValue: string = '';
  publishComment: (content: string) => void = () => {};

  build() {
    Row({ space: 10 }) {
      TextInput({ text: $$this.inputValue, placeholder: '回复~' })
        .layoutWeight(1)
        .height(40)

      Button('发布')
        .onClick(() => {
          console.log('inputValue: ', this.inputValue)
          this.publishComment(this.inputValue);
        })
    }
    .width('100%')
    .height(60)
    .backgroundColor('#fff')
    .padding({ left: 10, right: 10 })
    .border({
      color: '#e4e5e6',
      width: {
        top: 1
      }
    })
  }
}

export { HmReplyInput }