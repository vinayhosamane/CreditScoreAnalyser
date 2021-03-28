//
//  CreditScoreModel.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//

import Foundation

struct Scale: Codable {
    var type: String
    var min: Int
    var max: Int
    var colorHex: String
}

struct CreditScore: Codable {
    var score: Double
    var scales: [Scale]
}
