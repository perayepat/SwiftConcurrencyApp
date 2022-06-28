//
//  SwiftConcurrencyApp.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/24.
//

import SwiftUI

@main
struct SwiftConcurrencyApp: App {
    @StateObject var courseViewModel = CourseViewModel()
    @StateObject var sectionViewModel = SectionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(courseViewModel)
                .environmentObject(sectionViewModel)
        }
    }
}
