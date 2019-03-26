//
//  ZORService.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 28/05/2017.
//  Copyright © 2017 Ozgun Zor. All rights reserved.
//

import UIKit

enum API {}

extension API {
    static func getSomething() -> Endpoint<Something> {
//        return Endpoint(path: "something/profile")
        return Endpoint(path: "5c99561a320000743ed90892")
    }
    
    static func getSomethings() -> Endpoint<[Something]> {
//        return Endpoint(path: "somethings")
        return Endpoint(path: "5c9958b13200004f00d9089a")
    }
    
    static func postSomething(name: String) -> Endpoint<Something> {
        return Endpoint(
            method: .post,
            path: "something/profile",
            parameters: ["name" : name]
        )
    }
    
    static func postSomethingObject(something: Something) -> Endpoint<Something> {
        return Endpoint(
            method: .post,
            path: "something/profile",
            parameters: ["something" : something]
        )
    }
}

// MARK: Using Endpoints

func test() {
//    let client = HTTPClient(accessToken: "<access_token>")
    let client = HTTPClient()
    _ = client.request(API.getSomething())
    _ = client.request(API.getSomethings())
    _ = client.request(API.postSomething(name: "NameSomething"))
    _ = client.request(API.postSomethingObject(something: Something(name: "NameSomething")))
}


class ZORService {
    let client = HTTPClient()
}


