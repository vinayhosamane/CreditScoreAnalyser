//
//  DataConstructor.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 02/04/21.
//

import Foundation

protocol DataConnstructable {
    func fetchData(for jsonName: String, onCompletion onComplete: (Result<CreditScore, Error>) -> Void)
}

// responsible for fetching json to rennder dashboard
class DataConstructor: DataConnstructable {

    static let shared = DataConstructor()
    
    private init() {}
    
    // fetch json data annd pass it to consumer.
    func fetchData(for jsonName: String, onCompletion onComplete: (Result<CreditScore, Error>) -> Void) {
        do {
            if let jsonPath = Bundle.main.path(forResource: jsonName, ofType: "json"),
               let jsonData = try String(contentsOfFile: jsonPath).data(using: .utf8) {
                let result = try JSONDecoder().decode(CreditScore.self, from: jsonData)
                onComplete(.success(result))
            }
        } catch(let error) {
            print("something is wrong with json de-serialization")
            onComplete(.failure(error))
        }
    }
    
}
