//
//  CreditScore.swift
//  circlescore
//
//  Created by Amish Patel on 21/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

class CreditScoreModel: Codable {
    let score: Int
    let maxScore: Int
    
    enum CodingKeys: String, CodingKey {
        case creditReportInfo
    }
    
    enum NestedKeys: String, CodingKey {
        case score = "score"
        case maxScore = "maxScoreValue"
    }

    required init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let nestedValues = try values.nestedContainer(keyedBy: NestedKeys.self, forKey: .creditReportInfo)
        score = try nestedValues.decode(Int.self, forKey: .score)
        maxScore = try nestedValues.decode(Int.self, forKey: .maxScore)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nestedContainer = container.nestedContainer(keyedBy: NestedKeys.self, forKey: .creditReportInfo)
        try nestedContainer.encode(score, forKey: .score)
        try nestedContainer.encode(maxScore, forKey: .maxScore)
    }
}
