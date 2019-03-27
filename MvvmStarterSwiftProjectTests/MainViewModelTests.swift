//
//  MainViewModelTests.swift
//  MvvmStarterSwiftProjectTests
//
//  Created by Ozgun Zor on 3/26/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import XCTest
@testable import MvvmStarterSwiftProject

class MainViewModelTests: XCTestCase {
    
    private let viewModel = MainViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainViewModelForMappingModels() {
        var models: Array<Something> = []

        for i in 0..<5 {
            models.append(Something(name: "Name \(i)"))
        }
        
        let viewModels = viewModel.getSomethingViewModels(with: models)
        XCTAssertTrue(viewModels.count == models.count)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
