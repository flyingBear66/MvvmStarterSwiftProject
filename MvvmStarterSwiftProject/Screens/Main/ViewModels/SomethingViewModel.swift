//
//  SomethingViewModel.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 3/26/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift

class SomethingViewModel: ZORViewModel {
    
    public let name: Variable<String> = Variable("Init")
    
    private var model: Something?
    
    init(somethingModel: Something) {
        self.name.value = somethingModel.name
        self.model = somethingModel
    }

}
