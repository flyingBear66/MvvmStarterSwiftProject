//
//  MainViewController.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 27/05/2017.
//  Copyright © 2017 Ozgun Zor. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: ZORViewController {
    
    var viewModel = MainViewModel()
    var disposeBag = DisposeBag()

    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.prepareViewModel()
    }
    
    // MARK: - Helper Methods
    
    func prepareViewModel() {
        
        // observing errors to show
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internalError(let message):
                    print("Internal Error \(message)")
                case .serverError(let message):
                    print("Server Error \(message)")
                }
            })
            .disposed(by: disposeBag)
        
        // binding something to view
        
        viewModel
            .something
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                // Do when something changed
            }).disposed(by: disposeBag)
        
        // binding somethings to view

        viewModel
            .somethings
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                // Do when somethings changed
                
            }).disposed(by: disposeBag)
        
    }
    
    func prepareUI() {
        
    }
    
    
}
