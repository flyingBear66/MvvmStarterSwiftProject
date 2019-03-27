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
    @IBOutlet weak var somethingsTableView: UITableView!
    
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
        
//        // binding something to view
//        viewModel
//            .something
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { something in
//                // Do when something changed
//                print("Something Changed")
//                self.mainLabel.text = "Something \(something.name)"
//            }).disposed(by: disposeBag)
        
        // binding something to view
        viewModel
            .something
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { something in
                // Do when something changed
                print("Something Changed")
                self.mainLabel.text = "Something \(something.name)"
            }).disposed(by: disposeBag)
        
        // binding somethings to view
        viewModel
            .somethingViewModelsChanged
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { somethingViewModels in
                // Do when somethings changed
                print("Somethings Changed")
//                self.mainLabel.text = "Somethings \(somethingViewModels.first?.name ?? "nil")" // Prev
                self.somethingsTableView.reloadData()
            }).disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.getSomething()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.getSomethings()
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // Change `2.0` to the desired number of seconds.
//            // Code you want to be delayed
//            self.viewModel.getSomething()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) { // Change `2.0` to the desired number of seconds.
//            // Code you want to be delayed
//            self.viewModel.getSomethings()
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.viewModel.postSomethingObject()
        }
    }
    
    func prepareUI() {
        somethingsTableView.register(UINib(nibName: "SomethingTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        somethingsTableView.dataSource = self
    }
    
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.somethingCount.value
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel: SomethingViewModel = self.viewModel.somethingViewModels.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SomethingTableViewCell
        
        cell.viewModel = viewModel
        
        return cell
    }
}
