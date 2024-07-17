//
//  NoteView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct NoteView: View {
    
//    @State private var notes: String = ""
    @Binding var note: Note
    
    @FocusState var keyboardFocused
    var body: some View {
        ZStack{
            Color.notesBackground.ignoresSafeArea()
            VStack {
                
                HStack{
                    HStack(spacing: 15){
                        Text("Title")
                            .font(.headline)
                            .bold()
                        
                        Divider()
                        
                        Text("Heading")
                            .font(.subheadline)
                        
                        Divider()
                        
                        Text("Body")
                        Divider()
                        Button(action: {
                        }) {
                            Image(systemName: "bold")
                        }
                        Divider()
                        Button(action: {
                        }) {
                            Image(systemName: "underline")
                        }
                        Divider()
                        Button(action: {
                        }) {
                            Image(systemName: "italic")
                        }
                    }
                    .foregroundStyle(.background)
                    .buttonStyle(.plain)
                }
                .frame(height: 12)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.primaryBlue))
                
//                TextView(attributedText: $notes, allowsEditingTextAttributes: true, font: .systemFont(ofSize: 32))
////                    .background(.red)
                TextEditor(text: $note.content)
                    .scrollContentBackground(.hidden)
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                
//                Text(.init(notes))
                
                Button{
                    
                } label: {
                    Text("I don't know where to start")
                        .font(.footnote)
                        .padding()
                        .foregroundStyle(.red)
                        .background(Capsule().foregroundStyle(.labelPrimary))
                }.padding(.top)
                
                Spacer()
            }
        }.toolbar {
            if note.content != "" {
                
                NavigationLink{
                    EmotionRateView(note: $note)
                }label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
    
    
   
}

#Preview {
    NoteView(note: .constant(Note(content: "", fileURL: URL(filePath: ""), emotion: "")))
}
