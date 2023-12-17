//
//  CigaretteStore.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 06/12/23.
//

import Foundation
import SwiftData

@Model
class CigaretteStore: Identifiable {
    var id: UUID
    var cigaretteName: String
    var priceCigarette: Float
    var emotion: Emotion

    init(id: UUID = UUID(), cigaretteName: String = "", priceCigarette: Float = 0.0, emotion: Emotion = .neutral) {
        self.id = id
        self.cigaretteName = cigaretteName
        self.priceCigarette = priceCigarette
        self.emotion = emotion
    }
}
