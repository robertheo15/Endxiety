//
//  TextOrVoiceView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI
import SwiftData

struct TextOrVoiceView: View {
    
    @State var selectedNote: Note = Note(content: "")
    
    var body: some View {
        VStack{
            NavigationLink{
                NoteView(note:$selectedNote)
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
