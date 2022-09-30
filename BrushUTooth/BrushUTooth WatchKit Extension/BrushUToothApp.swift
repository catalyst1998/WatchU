//
//  BrushUToothApp.swift
//  BrushUTooth WatchKit Extension
//
//  Created by bytedance on 2022/9/29.
//

import SwiftUI

@main
struct BrushUToothApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            // `.task` runs only once when the app starts
            .task {
                _ = HealthStore.shared
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
