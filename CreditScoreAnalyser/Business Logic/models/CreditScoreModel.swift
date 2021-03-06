//
//  CreditScoreModel.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//

import Foundation

struct Scale: Decodable {
    var type: String
    var min: Int
    var max: Int
    var colorHex: String
    var percentile: String
}

struct CreditScore: Decodable {
    var score: Double
    var scaleMin: Int
    var scaleMax: Int
    var scales: [Scale]
}
