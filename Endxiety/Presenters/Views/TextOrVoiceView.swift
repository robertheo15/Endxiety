//
//  TextOrVoiceView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI
import SwiftData

struct TextOrVoiceView: View {
    
    @State var selectedRecord: Record = Record(createdAt: Date(), isPlaying: false, content: "")

    var body: some View {
        VStack{
            NavigationLink{
                NoteView(record: $selectedRecord)
            } label: {
                Image(systemName: "note.text")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height / 4)
                    .background(RoundedRectangle(cornerRadius: 12))
            }
            
                Text("or")
                .font(.title)
            
            NavigationLink{
                VoiceRecordView()
            } label: {
                Image(systemName: "mic")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height / 4)
                    .background(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    TextOrVoiceView()
}
