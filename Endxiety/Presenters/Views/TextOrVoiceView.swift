//
//  TextOrVoiceView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct TextOrVoiceView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showingSheet: Bool
    @Binding var note: Note
    var body: some View {
        NavigationView{
        ZStack {
            Color.backgroundPrimary.ignoresSafeArea()
            VStack{
                HStack {
                    Text("Select Your Preferred Way\nTo Journal")
                        .bold()
                        .font(.title)
                    Spacer()
                }.padding()
                NavigationLink{
                    NoteView(note: $note)
//                    dismiss()
                } label: {
                    Image("write_il")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height / 3.5)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Text("or")
                    .font(.title)
                    .bold()
                
                NavigationLink{
                    VoiceRecordView(note: $note)
                } label: {
                    Image("record_il")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height / 3.5)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            Spacer()
        }
    }
    }
}

//#Preview {
//    TextOrVoiceView()
//}
