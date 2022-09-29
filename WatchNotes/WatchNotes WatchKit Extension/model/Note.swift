//
//  Note.swift
//  WatchNotes WatchKit Extension
//
//  Created by bytedance on 2022/9/28.
//

import Foundation

struct Note:Identifiable, Codable {
    let id: UUID
    let text: String
}
