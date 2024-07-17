//
//  Recording.swift
//  NoteApp
//
//  Created by Ali Haidar on 15/07/24.
//

import Foundation
import SwiftData

@Model
class Record {
    var id = UUID()
    var fileURL : URL
    var createdAt : Date
    var isPlaying : Bool
    var content: String = ""
    var editedAt: Date
    
    init(id: UUID = UUID(), fileURL : URL = URL(string: "asd")!, createdAt: Date, isPlaying: Bool, content: String, editedAt: Date = Date()) {
        self.id = id
        self.content = content
        self.editedAt = editedAt
        self.createdAt = createdAt
        self.fileURL = fileURL
        self.isPlaying = isPlaying
    }
}
