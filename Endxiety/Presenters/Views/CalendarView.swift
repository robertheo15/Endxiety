//
//  CalendarView.swift
//  Endxiety
//
//  Created by Ali Haidar on 17/07/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var vm = VoiceViewModel()
    var body: some View {
        ZStack {
            Color.backgroundPrimary.ignoresSafeArea()
            
            ScrollView(showsIndicators: false){
                VStack{
                    CalendarItemView()
                    Spacer()
                    VStack {
                        ForEach(vm.recordingsList, id: \.id) { recording in
                            
                            RecordingItemView(vm: vm, recording: recording)
                            
                        }
                    }.padding()
                        .background(RoundedRectangle(cornerRadius: 14).frame(width: UIScreen.main.bounds.width - 25).foregroundStyle(.notesBackground))
                    
                    
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}
