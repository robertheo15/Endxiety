//
//  NoteRowView.swift
//  Endxiety
//
//  Created by Felix Laurent on 16/07/24.
//

import SwiftUI

struct NoteRowView: View {
    let note : Record
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm"
        return formatter.string(from: note.editedAt)
    }
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 65, height: 65)
                .padding()
            VStack (alignment: .leading) {
                Text(note.content)
                    .font(.system(size: 12))
                    .lineLimit(2)
                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                    .padding(.trailing)
                
                Text("Last Edited " + formattedDate)
                    .font(.system(size: 10))
            }
            Spacer()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(.white)
        )
    }
}

//#Preview {
//    NoteRowView(note: Note(content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor  incididunt ut labore et dolore magna aliqua", editedAt: Date()))
//}
