//
//  ZORViewModel.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 28/05/2017.
//  Copyright © 2017 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift

public enum HomeError {
    case internalError(String)
    case serverError(String)
}

class ZORViewModel: NSObject {
    public let error: PublishSubject<HomeError> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
}
