//
//  NotificationManager.swift
//  LocalNotificationProject
//
//  Created by Benny Davidovitz on 26/04/2022.
//

import UIKit
import UserNotifications


class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
        
    private func setup() {
        let approveAction = UNNotificationAction(identifier: "approve", title: "אשר", options: .authenticationRequired, icon: UNNotificationActionIcon(systemImageName: "person"))
        let viewAction = UNNotificationAction(identifier: "view", title: "צפה בפרופיל", options: .foreground, icon: nil)
        let replyAction = UNTextInputNotificationAction(identifier: "reply", title: "שלח הודעה", options: .authenticationRequired, textInputButtonTitle: "שלח", textInputPlaceholder: "כתוב משהו")
        
        let category = UNNotificationCategory(identifier: "friendRequest", actions: [approveAction, viewAction, replyAction], intentIdentifiers: [], options: [.allowInCarPlay, .allowAnnouncement])
        let catrogiesSet: Set<UNNotificationCategory> = [category]
        //array vs set
        //[1,1,2,3]
        //array => 4 elements [1,1,2,3], order kept
        //set => 3 elements [1,2,3], order might not kept
        UNUserNotificationCenter.current().setNotificationCategories(catrogiesSet)
    }
        
    func requestPermission() {
        setup()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("did grant authorizatiaon \(granted)")
            if let error = error {
                print(error)
            }
            
            if granted {
                //device token is received in AppDelegate.swift
                DispatchQueue.main.async { //on main thread
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func cleanBadge() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func requestNotification(title: String, body: String, soundName: String, badge: Int, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        //content.subtitle = "subtitle demo"
        //content.sound = .default
        content.sound = UNNotificationSound(named: .init(rawValue: soundName + ".wav"))
        content.badge = badge as NSNumber
        
        //if let videoUrl = Bundle.main.url(forResource: "developers_vid", withExtension: "mp4"),
        //if let videoUrl = Bundle.main.url(forResource: "steve_ballmer", withExtension: "jpeg"),
        //if let videoUrl = Bundle.main.url(forResource: "fast-small-sweep-transition", withExtension: "wav"),
        if let videoUrl = Bundle.main.url(forResource: "developers_vid", withExtension: "mp4"),
           let attachment = try? UNNotificationAttachment(identifier: "attach", url: videoUrl, options: nil) {
            content.attachments = [attachment]
        }
        
        //hook to actions
        content.categoryIdentifier = "friendRequest"
        //additional info
        content.userInfo = [
            "user_id": 42,
            "user_name": "Steve Ballmer"
        ]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "some-id", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("failed to request notification \(error)")
            } else {
                print("requested succesfully")
            }
        }
    }
    
}


extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.cleanBadge()
        let userInfo = response.notification.request.content.userInfo
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("user clicked notification")
            FlowManager.shared.showUserProfile(with: userInfo)
        case "approve":
            print("user approved notification. TODO: send to server")
        case "view":
            print("user clicked view profile")
            FlowManager.shared.showUserProfile(with: userInfo)
        case "reply":
            let text = (response as? UNTextInputNotificationResponse)?.userText ?? ""
            print("user clicke reply with text:" + text + " TODO: send text to server")
        default:
            print("unhandled action " + response.actionIdentifier)
        }
        
        //print(response)
        //completionHandler - notify iOS that we finished handling the response
        completionHandler()
    }
    
}
