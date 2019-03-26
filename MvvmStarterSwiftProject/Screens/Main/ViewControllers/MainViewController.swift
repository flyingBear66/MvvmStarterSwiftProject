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
    
    // MARK: - UIControls
    @IBOutlet weak var mainLabel: ZORLabel!
    
    // MARK: - Variables
    
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
        
        // observing loading state
        viewModel
            .loading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { loading in
                if loading {
                    print("Loading")
                } else {
                    print("Finished")
                }
            }).disposed(by: disposeBag)
        
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
            .subscribe(onNext: { something in
                // Do when something changed
                print("Something Changed")
                self.mainLabel.text = "Something \(something.name)"
            }).disposed(by: disposeBag)
        
        // binding somethings to view
        viewModel
            .somethings
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { somethings in
                // Do when somethings changed
                print("Somethings Changed")
                self.mainLabel.text = "Somethings \(somethings.first?.name ?? "nil")" 
            }).disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.getSomething()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.getSomethings()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.getSomething()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.getSomethings()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.postSomethingObject()
        }
    }
    
    func prepareUI() {
        
    }
    
    
}
