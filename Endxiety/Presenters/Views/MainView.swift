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
                    Label("My Notes", systemImage: "note.text")
                }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            InsightView()
                .tabItem {
                    Label("Insight", systemImage: "chart.bar.xaxis")
                }
        }
        .accentColor(.primaryBlue)
        .navigationBarBackButtonHidden()
            
          
    }
}

#Preview {
    MainView()
}
