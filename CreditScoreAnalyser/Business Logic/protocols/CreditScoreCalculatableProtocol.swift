//
//  CreditScoreCalculatableProtocol.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//

import Foundation
import UIKit

protocol CreditScoreCalculatable {
    var creditScoreReport: CreditScore? { get }
    
    func getCreditScore() -> Double
    func getCreditScoreScales() -> [Scale]?
    func getCreditScoreColor() -> UIColor?
    func doesScoreBelongsToScale(score: Double, scale: Scale) -> Bool
}

extension CreditScoreCalculatable {

    func getCreditScore() -> Double {
        return creditScoreReport?.score ?? 0.0
    }

}
