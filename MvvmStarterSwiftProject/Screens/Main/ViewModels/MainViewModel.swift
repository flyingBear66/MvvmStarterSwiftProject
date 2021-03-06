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
    
    //    public let somethings: PublishSubject<[Something]> = PublishSubject() // Prev
    public let something: PublishSubject<Something> = PublishSubject()
    public let somethingCount: Variable<Int> = Variable(0)
    public let somethingViewModels: Variable<[SomethingViewModel]> = Variable([])
    public let somethingViewModelsChanged: PublishSubject<[SomethingViewModel]> = PublishSubject()

    var service: MainServiceProtocol?
    let disposeBag = DisposeBag()
    
    init(service: MainServiceProtocol = MainService.shared()) {
        self.service = service
    }
    
    func getSomething() {
        self.loading.onNext(true)
        guard let service = service else {
            self.error.onNext(.internalError("Service is not initilized correctly"))
            self.loading.onNext(false)
            return
        }
        service.getSomething().bind { something in
            self.something.onNext(something)
            self.loading.onNext(false)
        }.disposed(by: disposeBag)
    }
    
    func getSomethings() {
        self.loading.onNext(true)
        guard let service = service else {
            self.error.onNext(.internalError("Service is not initilized correctly"))
            self.loading.onNext(false)
            return
        }
        service.getSomethings().bind { somethings in
            self.somethingCount.value = somethings.count
            let viewModels = self.getSomethingViewModels(with: somethings)
            self.somethingViewModels.value = viewModels
            self.somethingViewModelsChanged.onNext(viewModels)
            self.loading.onNext(false)
        }.disposed(by: disposeBag)
    }
    
    func postSomethingObject() {
//        self.loading.onNext(true)
//        guard let service = service else {
//            self.error.onNext(.internalError("Service is not initilized correctly"))
//            self.loading.onNext(false)
//            return
//        }
//        let something = Something(name: "NameSomething")
//        service.postSomethingObject(something: something).bind { something in
//            self.something.onNext(something)
//        }.disposed(by: disposeBag)
    }
    
    func getSomethingViewModels(with somethingModels:[Something]) -> [SomethingViewModel] {
        return somethingModels.map({ something -> SomethingViewModel in
            SomethingViewModel(somethingModel: something)
        })
    }

}
