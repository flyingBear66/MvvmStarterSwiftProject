//
//  MainService.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 28/05/2017.
//  Copyright © 2017 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MainServiceProtocol : class {
    func getSomething() -> Observable<Something>
    func getSomethings() -> Observable<[Something]>
    func postSomethingObject(something: Something) -> Observable<Something>
}

final class MainService: ZORService, MainServiceProtocol {
    
    // MARK: - Properties
    
    private static var sharedNetworkManager: MainService = {
        let networkManager = MainService()
        return networkManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> MainService {
        return sharedNetworkManager
    }
    
    // MARK: - Services

    func getSomething() -> Observable<Something> {
        return client.request(API.getSomething()).asObservable()
    }
    
    func getSomethings() -> Observable<[Something]> {
        return client.request(API.getSomethings()).asObservable()
    }
    
    func postSomethingObject(something: Something) -> Observable<Something> {
        return client.request(API.postSomethingObject(something: something)).asObservable()
    }
    
}
