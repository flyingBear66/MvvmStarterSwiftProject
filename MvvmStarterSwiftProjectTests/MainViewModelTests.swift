//
//  MainViewModelTests.swift
//  MvvmStarterSwiftProjectTests
//
//  Created by Ozgun Zor on 3/26/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import MvvmStarterSwiftProject

class MainViewModelTests: XCTestCase {
    
    // MARK - Variables

    var viewModel : MainViewModel!
    fileprivate var service : MockMainService!
    let disposeBag = DisposeBag()
    
    // MARK - Setups

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.service = MockMainService()
        self.viewModel = MainViewModel(service: self.service)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.service = nil
    }

    // MARK - Tests

    func testMainViewModelForMappingModels() {
        let models: [Something] = getSomethingsModels()
        let viewModels = viewModel.getSomethingViewModels(with: getSomethingsModels())
        XCTAssertTrue(viewModels.count == models.count)
    }
    
    func testGetSomethingWithNoService() {
        
        // giving no service to a view model
        viewModel.service = nil
        
        // observing errors to show
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssert(true, "ViewModel should not be able to fetch without service")
            })
            .disposed(by: disposeBag)
        
        // binding something to view
        viewModel
            .something
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { something in
                // Do when something changed
                XCTAssertFalse(something.name == "TestName", "Should not be the same without any service")
            }).disposed(by: disposeBag)
        
        // expected to not be able to fetch something
        viewModel.getSomething()
    }
    
    func testGetSomethingWithService() {
        
        // observing errors to show
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssert(false, "ViewModel should be able to fetch with service")
            })
            .disposed(by: disposeBag)
        
        // binding something to view
        viewModel
            .something
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { something in
                // Do when something changed
                XCTAssertTrue(something.name == "TestName", "Should be the same with MockService")
            }).disposed(by: disposeBag)
        
        // expected to not be able to fetch something
        viewModel.getSomething()
    }
}

// MARK - Helpers

fileprivate func getSomethingsModels() -> [Something] {
    var models: [Something] = []
    
    for i in 0..<5 {
        models.append(Something(name: "TestName \(i)"))
    }
    return models
}

fileprivate func getSomethingModel() -> Something {
    return Something(name: "TestName")
}

// MARK - Mock Service

fileprivate class MockMainService : MainServiceProtocol {
    
    let disposeBag = DisposeBag()

    var something: Something?
    
    func getSomething() -> Observable<Something> {
        return Single<Something>.create { observer in
            let something = getSomethingModel()
            observer(.success(something))
            return Disposables.create()
        }.asObservable()
    }
    
    func getSomethings() -> Observable<[Something]> {
        return Single<[Something]>.create { observer in
            observer(.success(getSomethingsModels()))
            return Disposables.create()
        }.asObservable()
    }

    func postSomethingObject(something: Something) -> Observable<Something> {
        return Single<Something>.create { observer in
            let something = getSomethingModel()
            observer(.success(something))
            return Disposables.create()
        }.asObservable()
    }
    
}
