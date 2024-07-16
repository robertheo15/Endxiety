//
//  Note.swift
//  Endxiety
//
//  Created by Felix Laurent on 16/07/24.
//

import Foundation
import SwiftData

@Model
final class Note: Identifiable {
    var id = UUID()
    var content: String
    var editedAt: Date
    
    init(id: UUID = UUID(), content: String, editedAt: Date = Date()) {
        self.id = id
        self.content = content
        self.editedAt = editedAt
    }
}

