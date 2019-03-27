//
//  SomethingTableViewCell.swift
//  MvvmStarterSwiftProject
//
//  Created by Ozgun Zor on 3/27/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SomethingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: ZORLabel!
    
    let disposeBag = DisposeBag()

    public var viewModel: SomethingViewModel! {
        didSet {
            self.bindViewModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel() {
        self.viewModel.name.asObservable().subscribe(onNext: { name in
            self.mainLabel.text = name
        }).disposed(by: disposeBag)
    }
}
