//
//  DonutViewTests.swift
//  circlescoreTests
//
//  Created by Amish Patel on 21/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
@testable import circlescore

class DonutViewTests: XCTestCase {
    
    func test_setTextForCreditScore_hasSameValueOnLabel() {
        
        let sut = makeSUT()
        
        sut.setTextForCreditScore(creditScore: 100)
        
        XCTAssertEqual("100", sut.creditScoreLabel.text)
    }
    
    func test_setTextForMaxScore_hasSameValueOnLabel() {
        let sut = makeSUT()
        sut.setTextForMaxScore(maxScore: 700)
        XCTAssertEqual("out of 700", sut.maxScoreLabel.text)
    }
    
    func test_updateScoreAndMaxScore_hasSameValuesOnLabels() {
        let sut = makeSUT()
        sut.updateScoreAndMaxScore(score: 300, maxScore: 500)
        
        XCTAssertEqual("300", sut.creditScoreLabel.text)
        XCTAssertEqual("out of 500", sut.maxScoreLabel.text)
    }
    
    private func makeSUT() -> DonutProgressView {
        let sut = DonutProgressView(frame: .zero)
        return sut
    }
}
