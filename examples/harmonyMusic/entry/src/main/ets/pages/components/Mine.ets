import media from '@ohos.multimedia.media';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
struct Mine {
  // avPlayer: media.AVPlayer =

  aboutToAppear() {
    media.createAVPlayer()
      .then((video: media.AVPlayer) => {
        if (video !== null) {
          console.info('createAVPlayer success');
          const avPlayer: media.AVPlayer = video;

          avPlayer.url = 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.m4a';
          avPlayer.play((error: BusinessError, data) => {
            if (error) {
              console.error(`AVPlayer play, error message: ${error}`);
            }
          })
        } else {
          console.info('createAVPlayer fail');
        }
      })
      .catch((error: BusinessError) => {
        console.error(`AVPlayer catchCallback, error message:${error.message}`);
      })
  }

  build() {
    Text('Mine')
      .fontColor('#fff')
  }
}

export { Mine }