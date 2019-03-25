//
//  ZORService.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 28/05/2017.
//  Copyright © 2017 Ozgun Zor. All rights reserved.
//

import UIKit

class ZORService: NSObject {

}

enum API {}

extension API {
    static func getSomething() -> Endpoint<Something> {
        return Endpoint(path: "something/profile")
    }
    
    static func postSomething(name: String) -> Endpoint<Something> {
        return Endpoint(
            method: .post,
            path: "something/profile",
            parameters: ["name" : name]
        )
    }
}

final class Something: Decodable {
    let name: String
}


// MARK: Using Endpoints
func test() {
    let client = HTTPClient(accessToken: "<access_token>")
    _ = client.request(API.getSomething())
    _ = client.request(API.postSomething(name: "NameSomething"))
}
