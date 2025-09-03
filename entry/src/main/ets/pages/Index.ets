import { LiveViewButtonArea } from './LiveViewButton'
import { GLComponent } from 'egl'

@Entry
@Component
struct Index {
    build() {
        RelativeContainer() {
            GLComponent()
                .height('100%')
                .width('100%')
        }
        .height('100%')
        .width('100%')
    }
}