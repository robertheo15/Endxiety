//
//  EmotionRateView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct EmotionRateView: View {
    @State private var selectedEmojiIndex: Int?
    @Binding var note: Note
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    var arrEmoji = ["SuperAnxious", "Anxious","Annoyed","Tense","Calm"]
    
    var body: some View {
        VStack{
            Text("What emoji that best describes you now?")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach (0..<arrEmoji.count, id: \.self) { index in
                        Button(action: {
                            self.selectedEmojiIndex = index
                        }) {
                            Image(arrEmoji[index])
                                .resizable()
                                .interpolation(.none)
                                .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                                .background(self.selectedEmojiIndex == index ? Circle().fill(Color.blue) : Circle().fill(Color.gray))
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .defaultScrollAnchor(.trailing)
            .contentMargins(.horizontal, 20, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .padding()
        .toolbar {
            if selectedEmojiIndex != nil{
                NavigationLink{
                    QuoteView()
                }label: {
                    Image(systemName: "checkmark")
//                        .onTapGesture {
//                            if (!note.content.isEmpty){
//                                note.editedAt = Date.now
//                                switch selectedEmojiIndex{
//                                    case 0:
//                                        note.emotion = "SuperAnxious"
//                                    case 1:
//                                        note.emotion = "Anxious"
//                                    case 2:
//                                        note.emotion = "Annoyed"
//                                    case 3:
//                                        note.emotion = "Tense"
//                                    case 4:
//                                        note.emotion = "Calm"
//                                default:
//                                    break
//                                }
//                                context.insert(note)
//                            }
//                            dismiss()
//                        }
                }
            }
        }
    }
}

#Preview {
    EmotionRateView(note: .constant(Note(content: "", fileURL: URL(filePath: ""), emotion: "", isPlaying: false)))
}
