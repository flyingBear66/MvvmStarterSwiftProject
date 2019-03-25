//
//  MainViewModel.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 28/05/2017.
//  Copyright © 2017 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift

class MainViewModel: ZORViewModel {
    
    public let something: PublishSubject<Something> = PublishSubject()
    public let somethings: PublishSubject<[Something]> = PublishSubject()

    let service = MainService()
    let disposeBag = DisposeBag()
    
    func getSomething() {
        self.loading.onNext(true)
        service.getSomething().bind { something in
            self.something.onNext(something)
            self.loading.onNext(false)
        }.disposed(by: disposeBag)
    }
    
    func getSomethings() {
        self.loading.onNext(true)
        service.getSomethings().bind { somethings in
            self.somethings.onNext(somethings)
            self.loading.onNext(false)
        }.disposed(by: disposeBag)
    }

}
