//
//  Item.swift
//  LearnAble
//
//  Created by Dron Haritwal on 24/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
