//
//  UserNotificationSimpleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/5.
//
import SwiftUI
import UserNotifications
import CoreLocation

struct UserNotificationSimpleView: View {
    var body: some View {
        VStack {
            Button("请求通知授权") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("发送时间通知") {
                NotificationManager.instance.scheduleNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

// 通知管理类
class NotificationManager {
    static let instance = NotificationManager() // Signleton
    
    // 请求授权
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    // 发送通知
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "这是我的第一个通知"
        content.subtitle = "简单的通知"
        content.sound = .default
        content.badge = 1
        
        // 时间通知（注意：只有当APP在后台运行的时候才会触发通知，在APP在前台运行的状态下是不会触发通知的。）
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // 日历通知
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 3
        // dateComponents.weekday = 3
        // dateComponents.month = 4
        // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 位置通知
        let coordinates = CLLocationCoordinate2D(latitude: 113.63445, longitude: 34.87179)
        let region = CLCircularRegion(center: coordinates, radius: 1000, identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}

struct UserNotificationSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        UserNotificationSimpleView()
    }
}
