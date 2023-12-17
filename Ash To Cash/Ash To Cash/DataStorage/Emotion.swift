//
//  Emotion.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 06/12/23.
//

import Foundation

enum Emotion: Int, CaseIterable, Codable {
    case angry = 1, sad, neutral, happy, excited

    var emoji: String {
        switch self {
        case .angry:
            return "😡"
        case .sad:
            return "☹️"
        case .neutral:
            return "😐"
        case .happy:
            return "🙂"
        case .excited:
            return "😄"
        }
    }
}
