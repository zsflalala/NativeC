import { LiveViewController } from './LiveViewUtil';
@Entry
@Component
struct Index {
    build() {
        RelativeContainer() {
            Flex({
                direction: FlexDirection.Column,
                justifyContent: FlexAlign.Center,
                alignItems: ItemAlign.Center
            }) {
                Button('🚴 配送时间', { type: ButtonType.Capsule, stateEffect: true }) // 胶囊按钮更美观
                    .alignSelf(ItemAlign.Center)
                    .backgroundColor('#317AF7')
                    .fontColor('#FFFFFF')
                    .fontSize(20)
                    .borderRadius(24)
                    .padding({ left: 24, right: 24, top: 12, bottom: 12 }) // 内边距
                    .width('100%')   // Row 占满全屏
                    .onClick(() => {
                        LiveViewController.startLiveView();
                        let i = 0;
                        const intervalId = setInterval(() => {
                            if (i <= 100) {
                                LiveViewController.updateLiveView(i, 300 - 3 * i, 50 - 0.5 * i);
                                i++;
                            } else {
                                clearInterval(intervalId);
                            }
                        }, 500);
                    })
            }
        }
    }
}