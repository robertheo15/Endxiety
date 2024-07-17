//
//  MainView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
       
        TabView{
            HomeView()
                .tabItem {
                    Label("My Notes", systemImage: "pencil.line")
                }
            TrendsView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            SettingsView()
                .tabItem {
                    Label("Insights", systemImage: "chart.bar.xaxis")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
