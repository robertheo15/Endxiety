//
//  Note.swift
//  NotesApp
//
//  Created by Felix Laurent on 13/07/24.
//

import Foundation
import SwiftData

@Model
final class Note: Identifiable {
    var id = UUID()
    var content: String
    var fileURL : URL
    var emotion: String
    var editedAt: Date
//    isNote true
    
    init(id: UUID = UUID(), content: String, fileURL: URL, emotion: String, editedAt: Date = Date()) {
        self.id = id
        self.content = content
        self.fileURL = fileURL
        self.emotion = emotion
        self.editedAt = editedAt
    }
}
