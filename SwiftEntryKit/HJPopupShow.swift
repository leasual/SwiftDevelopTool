//
//  HJPopupShow.swift
//  HJBookHouse
//
//  Created by James on 2019/8/15.
//  Copyright © 2019 james.li. All rights reserved.
//

import SwiftEntryKit
import UIKit

class HJPopupShow: NSObject {
    
    static var attributes: EKAttributes {
        var attributes = EKAttributes.topNote
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(UIColor.darkGray), EKColor(UIColor.darkGray)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.screenBackground = .color(color: EKColor(UIColor.black))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
        attributes.screenInteraction = .absorbTouches
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
        scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
        attributes.statusBar = .dark
        return attributes
    }
    
}

extension HJPopupShow {
    
    // MARK: Entry Samples
    
    // Bumps a standard note
    static func showNote(attributes: EKAttributes) {
        let text = "Pssst! I have something to tell you..."
        let style = EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKNoteMessageView(with: labelContent)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    static func showImageNote(attributes: EKAttributes) {
        
        // Set note label content
        let text = "The thrill is gone"
        let style = EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        let imageContent = EKProperty.ImageContent(image: UIImage(named: "achievementImage")!)
        
        let contentView = EKImageNoteMessageView(with: labelContent, imageContent: imageContent)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps an infinite processing note
    static func showProcessingNote(attributes: EKAttributes) {
        let text = "Waiting for the goodies to arrive!"
        let style = EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a status bar replacement entry
    static func showStatusBarMessage(attributes: EKAttributes) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        
        let contentView: UIView
        let font = UIFont.systemFont(ofSize: 12)
        let labelStyle = EKProperty.LabelStyle(font: font, color: .white, alignment: .center)
        if statusBarHeight > 20 {
            let leading = EKProperty.LabelContent(text: "My 🧠", style: labelStyle)
            let trailing = EKProperty.LabelContent(text: "Wonders!", style: labelStyle)
            contentView = EKXStatusBarMessageView(leading: leading, trailing: trailing)
        } else {
            let labelContent = EKProperty.LabelContent(text: "My 🧠 is doing some thinking...", style: labelStyle)
            let noteView = EKNoteMessageView(with: labelContent)
            noteView.verticalOffset = 0
            noteView.set(.height, of: statusBarHeight)
            contentView = noteView
        }
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Show rating view
    static func showRatingView(attributes: EKAttributes) {
        let unselectedImage = EKProperty.ImageContent(image: UIImage(named: "achievementImage")!)
        let selectedImage = EKProperty.ImageContent(image: UIImage(named: "achievementImage")!)
        
        let initialTitle = EKProperty.LabelContent(text: "Rate our food", style: .init(font: UIFont.systemFont(ofSize: 34), color: .black, alignment: .center))
        let initialDescription = EKProperty.LabelContent(text: "How was it?", style: .init(font: UIFont.systemFont(ofSize: 24), color: EKColor(UIColor.gray), alignment: .center))
        
        let items = [("💩", "Pooish!"), ("🤨", "Ahhh?!"), ("👍", "OK!"), ("👌", "Tasty!"), ("😋", "Delicius!")].map { texts -> EKProperty.EKRatingItemContent in
            let itemTitle = EKProperty.LabelContent(text: texts.0, style: .init(font: UIFont.systemFont(ofSize: 48), color: .black, alignment: .center))
            let itemDescription = EKProperty.LabelContent(text: texts.1, style: .init(font: UIFont.systemFont(ofSize: 24), color: .black, alignment: .center))
            return .init(title: itemTitle, description: itemDescription, unselectedImage: unselectedImage, selectedImage: selectedImage)
        }
        
        var message: EKRatingMessage!
        
        // Generate buttons content
        let lightFont = UIFont.systemFont(ofSize: 20)
        let mediumFont = UIFont.systemFont(ofSize: 20)
        
        // Close button - Just dismiss entry when the button is tapped
        let grayColor = EKColor(UIColor.gray)
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: mediumFont, color: grayColor)
        let closeButtonLabel = EKProperty.LabelContent(text: "Dismiss", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  grayColor) {
            SwiftEntryKit.dismiss {
                // Here you may perform a completion handler
            }
        }
        
        // Ok Button - Make transition to a new entry when the button is tapped
        let pinkyColor = UIColor.purple
        let okButtonLabelStyle = EKProperty.LabelStyle(font: lightFont, color: EKColor(UIColor.purple))
        let okButtonLabel = EKProperty.LabelContent(text: "Tell us more", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(UIColor.purple)) {
            SwiftEntryKit.dismiss()
        }
        
        let buttonsBarContent = EKProperty.ButtonBarContent(with: closeButton, okButton, separatorColor: EKColor(UIColor.gray), horizontalDistributionThreshold: 1, expandAnimatedly: true)
        
        message = EKRatingMessage(initialTitle: initialTitle, initialDescription: initialDescription, ratingItems: items, buttonBarContent: buttonsBarContent) { index in
            // Rating selected - do something
        }
        
        let contentView = EKRatingMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a notification structured entry
    static func showNotificationMessage(attributes: EKAttributes, title: String, desc: String, textColor: UIColor, imageName: String? = nil) {
        let title = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 16), color: EKColor(UIColor.black)))
        let description = EKProperty.LabelContent(text: desc, style: .init(font: UIFont.systemFont(ofSize: 14), color: EKColor(UIColor.black)))
        var image: EKProperty.ImageContent?
        if let imageName = imageName {
            image = .init(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
        }
        
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a chat message structured entry
    static func showChatNotificationMessage(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(text: "Madi", style: .init(font: UIFont.systemFont(ofSize: 14), color: .white))
        let description = EKProperty.LabelContent(text: "Hey! I'll come by at your office for lunch... 🍲", style: .init(font: UIFont.systemFont(ofSize: 12), color: .white))
        let time = EKProperty.LabelContent(text: "09:00", style: .init(font: UIFont.systemFont(ofSize: 10), color: .white))
        let image = EKProperty.ImageContent.thumb(with: "ic_madi_profile", edgeSize: 35)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage, auxiliary: time)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    static func showDarkAwesomePopupMessage(attributes: EKAttributes) {
        let image = R.image.achievementImage()//UIImage(named: "ic_done_all_dark_48pt")!
        let title = "Awesome!"
        let description = "You are using SwiftEntryKit, and this is a customized alert view that is floating at the bottom."
        showPopupMessage(attributes: attributes, title: title, titleColor: .darkText, description: description, descriptionColor: UIColor.gray, buttonTitleColor: .white, buttonBackgroundColor: UIColor.darkGray, image: image)
    }
    
    static func showLightAwesomePopupMessage(attributes: EKAttributes) {
        let image = R.image.achievementImage()//UIImage(named: "ic_done_all_light_48pt")!
        let title = "Awesome!"
        let description = "You are using SwiftEntryKit, and this is a pop up with important content"
        showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: UIColor.gray, buttonBackgroundColor: .white, image: image)
    }
    
    static func showPopupMessage(attributes: EKAttributes, title: String, titleColor: UIColor, description: String, descriptionColor: UIColor, buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, image: UIImage? = nil) {
        
        var themeImage: EKPopUpMessage.ThemeImage?
        
        if let image = image {
            themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
        }
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 24), color: EKColor(UIColor.black), alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: UIFont.systemFont(ofSize: 16), color: EKColor(UIColor.lightGray), alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: "Got it!", style: .init(font: UIFont.systemFont(ofSize: 16), color: EKColor(UIColor.black))), backgroundColor: EKColor(UIColor.black), highlightedBackgroundColor: EKColor(UIColor.black))
        let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
            SwiftEntryKit.dismiss()
        }
        
        let contentView = EKPopUpMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Cumputed for the sake of reusability
    static var bottomAlertAttributes: EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.entryBackground = .color(color: .white)
        attributes.screenBackground = .color(color: EKColor(UIColor.gray))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 25)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)),
                                             scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
        attributes.statusBar = .dark
        return attributes
    }
    
    static func showButtonBarMessage(attributes: EKAttributes) {

        // Generate textual content
        let title = EKProperty.LabelContent(text: "Dear Reader!", style: .init(font: UIFont.systemFont(ofSize: 15), color: .black))
        let description = EKProperty.LabelContent(text: "Get your coupon for a free book now", style: .init(font: UIFont.systemFont(ofSize: 13), color: .black))
        let image = EKProperty.ImageContent(imageName: "achievementImage", size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)

        // Generate buttons content
        let buttonFont = UIFont.systemFont(ofSize: 16)

        // Close button - Just dismiss entry when the button is tapped
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor(UIColor.gray))
        let closeButtonLabel = EKProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(UIColor.gray)) {
            SwiftEntryKit.dismiss()
        }

        // Ok Button - Make transition to a new entry when the button is tapped
        let okButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor(UIColor.brown))
        let okButtonLabel = EKProperty.LabelContent(text: "WHY NOT! LET ME HAVE IT NOW", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(UIColor.brown)) {
            var attributes = self.bottomAlertAttributes
            attributes.entryBackground = .color(color: EKColor(UIColor.brown))
            attributes.entranceAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0)))
            let image = UIImage(named: "achievementImage")!
            let title = "Congratz!"
            let description = "Your book coupon is 5w1ft3ntr1k1t"
            self.showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: UIColor.black, buttonBackgroundColor: .white, image: image)
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(with: closeButton, okButton, separatorColor: EKColor(UIColor.black), buttonHeight: 60, expandAnimatedly: true)

        // Generate the content
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, imagePosition: .left, buttonBarContent: buttonsBarContent)

        let contentView = EKAlertMessageView(with: alertMessage)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    static func showAlertView(attributes: EKAttributes) {
        
        // Generate textual content
        let title = EKProperty.LabelContent(text: "Hopa!", style: .init(font: UIFont.systemFont(ofSize: 15), color: .black, alignment: .center))
        let description = EKProperty.LabelContent(text: "This is a system-like alert, with several buttons. You can display even more buttons if you want. Click on one of them to dismiss it.", style: .init(font: UIFont.systemFont(ofSize: 13), color: .black, alignment: .center))
        let image = EKProperty.ImageContent(imageName: "achievementImage", size: CGSize(width: 25, height: 25), contentMode: .scaleAspectFit)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        
        // Generate buttons content
        let buttonFont = UIFont.systemFont(ofSize: 16)
        
        // Close button
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor(UIColor.gray))
        let closeButtonLabel = EKProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(UIColor.gray)) {
            SwiftEntryKit.dismiss()
        }
        
        // Remind me later Button
        let laterButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor(UIColor.brown))
        let laterButtonLabel = EKProperty.LabelContent(text: "MAYBE LATER", style: laterButtonLabelStyle)
        let laterButton = EKProperty.ButtonContent(label: laterButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(UIColor.brown)) {
            SwiftEntryKit.dismiss()
        }
        
        // Ok Button
        let okButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor(UIColor.brown))
        let okButtonLabel = EKProperty.LabelContent(text: "SHOW ME", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(UIColor.brown)) {
            SwiftEntryKit.dismiss()
        }
        
        // Generate the content
        let buttonsBarContent = EKProperty.ButtonBarContent(with: okButton, laterButton, closeButton, separatorColor: EKColor(UIColor.lightGray), expandAnimatedly: true)
        
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonsBarContent)
        
        // Setup the view itself
        let contentView = EKAlertMessageView(with: alertMessage)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a custom nib originated view
//    static func showCustomNibView(attributes: EKAttributes) {
//        SwiftEntryKit.display(entry: NibExampleView(), using: attributes)
//    }
//
//    // Bumps a custom view controller that is using a view from nib
//    static func showCustomViewController(attributes: EKAttributes) {
//        let viewController = ExampleViewController(with: NibExampleView())
//        SwiftEntryKit.display(entry: viewController, using: attributes)
//    }
//
//    // Sign in form
//    static func showSigninForm(attributes: EKAttributes, style: FormStyle) {
//        let title = EKProperty.LabelContent(text: "Sign in to your account", style: style.title)
//        let textFields = FormFieldPresetFactory.fields(by: [.email, .password], style: style)
//        let button = EKProperty.ButtonContent(label: .init(text: "Continue", style: style.buttonTitle), backgroundColor: style.buttonBackground, highlightedBackgroundColor: style.buttonBackground.withAlphaComponent(0.8)) {
//            SwiftEntryKit.dismiss()
//        }
//        let contentView = EKFormMessageView(with: title, textFieldsContent: textFields, buttonContent: button)
//        SwiftEntryKit.display(entry: contentView, using: attributes)
//    }
//
//    // Sign up form
//    static func showSignupForm(attributes: inout EKAttributes, style: FormStyle) {
//        let title = EKProperty.LabelContent(text: "Fill your personal details", style: style.title)
//        let textFields = FormFieldPresetFactory.fields(by: [.fullName, .mobile, .email, .password], style: style)
//        let button = EKProperty.ButtonContent(label: .init(text: "Continue", style: style.buttonTitle), backgroundColor: style.buttonBackground, highlightedBackgroundColor: style.buttonBackground.withAlphaComponent(0.8)) {
//            SwiftEntryKit.dismiss()
//        }
//        let contentView = EKFormMessageView(with: title, textFieldsContent: textFields, buttonContent: button)
//        attributes.lifecycleEvents.didAppear = {
//            contentView.becomeFirstResponder(with: 0)
//        }
//        SwiftEntryKit.display(entry: contentView, using: attributes, presentInsideKeyWindow: true)
//    }
}
