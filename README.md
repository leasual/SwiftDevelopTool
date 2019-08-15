# SwiftDevelopTool
Swift开发常用库和控件使用

SwiftEntryKit

```swift
/// ---------- 属性说明
//    /// 配置样式
//    fileprivate func configure () {
//
//        /**
//         * topToast 导航栏通知消息样式
//         * bottomToast Tabbar底部通知消息样式
//         * topNote 小导航栏通知样式
//         * bottomNote Tabbar底部小通知消息样式
//         * statusBar 状态栏通知样式
//         * topFloat 顶部浮窗
//         * bottomFloat 底部浮窗
//         * centerFloat 中间浮窗口
//         * float 浮窗
//         */
//        var attributes = EKAttributes.float
//        /// 设置名称 可以查询是否显示
//        //attributes.name = "弹窗名称标识符name0011"
//        //SwiftEntryKit.isCurrentlyDisplaying(entryNamed: "弹窗名称标识符name0011")
//        /// 窗口等级
//        attributes.windowLevel = .normal
//        /// 样式位置
//        attributes = .float
//        /// 弹出位置
//        attributes.position = .top
//        /// 持续时间 一直显示
//        attributes.displayDuration = .infinity
//        /// 窗口优先级 覆盖上个弹窗
//        attributes.precedence = .override(priority: .max, dropEnqueuedEntries: false)
//        ///EKAttributes.Precedence.QueueingHeuristic.value = .priority
//        /// 窗口默认尺寸
//        attributes.positionConstraints.size = .init(width: EKAttributes.PositionConstraints.Edge.fill, height: EKAttributes.PositionConstraints.Edge.constant(value: 100))
//        /// 窗口最大尺寸
//        attributes.positionConstraints.maxSize = .init(width: EKAttributes.PositionConstraints.Edge.constant(value: 200), height: EKAttributes.PositionConstraints.Edge.constant(value: 200))
//        /// 可以覆盖安全区
//        //        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
//        /// 垂直偏移位置
//        //        attributes.positionConstraints.verticalOffset = 10
//        /// 是否跟随屏幕旋转
//        //        attributes.positionConstraints.rotation.isEnabled = false
//        /// 绑定键盘位置
//        //        let offset = EKAttributes.PositionConstraints.KeyboardRelation.Offset(bottom: 10, screenEdgeResistance: 20)
//        //        let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: offset)
//        //        attributes.positionConstraints.keyboardRelation = keyboardRelation
//        /// 投影背景
//        //attributes.shadow = .none
//        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))
//        /// 圆角样式
//        //        attributes.roundCorners = .top(radius: 10)
//        // attributes.roundCorners = .all(radius: 10)
//        // attributes.roundCorners = .none
//        /// 描边样式
//        //attributes.border = .value(color: .black, width: 0.5)
//        /// 弹出样式
//        //        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
//        //        attributes.popBehavior = .overridden
//        /// 状态栏样式
//        // attributes.statusBar = .light
//        // attributes.statusBar = .hidden
//        /// 动画效果
//        attributes.entranceAnimation = .init(
//            translate: .init(duration: 0.7, anchorPosition: .top, spring: .init(damping: 1, initialVelocity: 0)),
//            scale: .init(from: 0.6, to: 1, duration: 0.7),
//            fade: .init(from: 0.8, to: 1, duration: 0.3))
//        /// 背景样式
//        // 渐变背景
//        //let colors: [UIColor] = [.red, .green, .blue]
//        //attributes.entryBackground = .gradient(gradient: .init(colors: colors, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
//        // 毛玻璃
//        attributes.entryBackground = .color(color: .white)
//        attributes.screenBackground = .visualEffect(style: .light)
//        /// 滑动手势
//        // 禁止
//        // attributes.scroll = .disabled
//        // 动画
//        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
//        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
//        /// 交互操作
//        // 三秒后自动退出
//        // attributes.entryInteraction = .delayExit(by: 3)
//        // 点击自动消失
//        // attributes.entryInteraction = .dismiss
//        // attributes.screenInteraction = .dismiss
//        // 忽略点击
//        // attributes.entryInteraction = .absorbTouches
//        // attributes.screenInteraction = .absorbTouches
//        // 蒙版可点击
//        attributes.entryInteraction = .absorbTouches
//        attributes.screenInteraction = .dismiss
//        // 事件穿透
//        //         attributes.screenInteraction = .forward
//        //         attributes.entryInteraction = .dismiss
//        //        let action = {
//        //            // Do something useful
//        //        }
//        //        attributes.entryInteraction.customTapActions.append(action)
//
//        /// 生命周期事件注入
//        //        attributes.lifecycleEvents.willAppear = {
//        //            // Executed before the entry animates inside
//        //        }
//        //
//        //        attributes.lifecycleEvents.didAppear = {
//        //            // Executed after the entry animates inside
//        //        }
//        //
//        //        attributes.lifecycleEvents.willDisappear = {
//        //            // Executed before the entry animates outside
//        //        }
//        //
//        //        attributes.lifecycleEvents.didDisappear = {
//        //            // Executed after the entry animates outside
//        //        }
//
//    }
```
