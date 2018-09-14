//
//  DigitalCoinsMarketDataTests.swift
//  DigitalCoinsMarketDataTests
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import XCTest
@testable import DigitalCoinsMarketData
import ObjectMapper

class DigitalCoinsMarketDataTests: XCTestCase {
    
    
    var digitalCoinTableViewModelTest:DigitalCoinTableViewModel? = nil
    var digitalCoinModel:DigitalCoinViewModelData? = nil
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        let target: NetworkingManager = .data
        
        let sampleData = target.sampleData
        let message = String(data: sampleData, encoding: .utf8)
        
        digitalCoinModel = Mapper<DigitalCoinViewModelData>().map(JSONString: message!)!
        
        
        digitalCoinTableViewModelTest=DigitalCoinTableViewModel.init(digitalCoinDataArray: (digitalCoinModel?.data)!)
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    
        

    XCTAssertTrue(digitalCoinTableViewModelTest?.getDigitalCoinName(indexPath: IndexPath(row: 0, section: 0))=="NULS")
        


    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

