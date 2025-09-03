import { LiveViewController } from './LiveViewUtil';

@Builder
export function LiveViewButtonArea() {
    Flex({
        direction: FlexDirection.Column,
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Center
    }) {
        Button('🚴 配送时间', { type: ButtonType.Capsule, stateEffect: true })
            .alignSelf(ItemAlign.Center)
            .backgroundColor('#317AF7')
            .fontColor('#FFFFFF')
            .fontSize(20)
            .borderRadius(24)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .width('100%')
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
