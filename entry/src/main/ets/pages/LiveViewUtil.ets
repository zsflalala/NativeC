import { liveViewManager } from '@kit.LiveViewKit';
import { Want, wantAgent } from '@kit.AbilityKit';

export class LiveViewController{
  private static currentView: liveViewManager.LiveView | null = null;

  public static async startLiveView(): Promise<liveViewManager.LiveViewResult> {
    if (!await liveViewManager.isLiveViewEnabled()) throw new Error("Live view is disabled.");

    const view = await LiveViewController.buildDefaultView();
    LiveViewController.currentView = view;
    return await liveViewManager.startLiveView(view);
  }

  public static async updateLiveView(progress: number, distance: number, time: number): Promise<liveViewManager.LiveViewResult> {
    const view = LiveViewController.currentView;
    if (!view) throw new Error("LiveView has not been started yet.");

    const primary = view.liveViewData.primary;
    primary.content = [
      { text: "距商家 " },
      { text: `${distance} `, textColor: "#FF007DFF" },
      { text: "米 | " },
      { text: `${time} `, textColor: "#FF007DFF" },
      { text: "秒到店" }
    ];
    primary.layoutData = { layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS, progress };

    return await liveViewManager.updateLiveView(view);
  }

  private static async buildDefaultView(): Promise<liveViewManager.LiveView> {
    return {
      id: 0,
      event: "DELIVERY",
      liveViewData: {
        primary: {
          title: "骑手已接单",
          content: [
            { text: "距商家 " },
            { text: "300 ", textColor: "#FF007DFF" },
            { text: "米 | " },
            { text: "50 ", textColor: "#FF007DFF" },
            { text: "秒到店" }
          ],
          keepTime: 15,
          clickAction: await LiveViewController.buildWantAgent(),
          extensionData: {
            type: liveViewManager.ExtensionType.EXTENSION_TYPE_ICON,
            pic: 'icon_merchant.png'
          },
          layoutData: {
            layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS,
            progress: 0,
            color: "#FF317AF7",
            backgroundColor: "#f7819ae0",
            indicatorType: liveViewManager.IndicatorType.INDICATOR_TYPE_UP,
            indicatorIcon: "delivery_man.svg",
            lineType: liveViewManager.LineType.LINE_TYPE_DOTTED_LINE,
            nodeIcons: ["building.png","food.png","building.png"],
          }
        }
      }
    };
  }

  public static async stopLiveView(): Promise<void> {
    if (!LiveViewController.currentView) return;
    try {
      liveViewManager.stopLiveView(LiveViewController.currentView);
      LiveViewController.currentView = null;
    } catch (err) {
      console.error("Stop LiveView failed:", err);
    }
  }

  private static async buildWantAgent(): Promise<Want> {
    const wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: 'com.example.myapplication',
          abilityName: 'EntryAbility'
        } as Want
      ],
      actionType: wantAgent.OperationType.START_ABILITIES,
      requestCode: 0,
      actionFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
    };

    const agent = await wantAgent.getWantAgent(wantAgentInfo);
    return agent;
  }
}