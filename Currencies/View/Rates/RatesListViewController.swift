//
//  RatesListViewController.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

class RatesListViewController: CommonTableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        title = (viewModel as? RatesViewModelProtocol)?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Register
    
    private func registerCells() {
        let cellIdentifier = RateTableViewCell.reuseIdentifier
        tableView?.register(NSClassFromString(cellIdentifier), forCellReuseIdentifier:cellIdentifier)
        let nib = RateTableViewCell.cellNib
        tableView?.register(nib, forCellReuseIdentifier:cellIdentifier)
        registerCell(with: cellIdentifier, forViewModelWith:RatecellViewModel.itemIdentifier)
    }
    
    //MARK: - Actions
    
    @IBAction func refreshPressed(sender:AnyObject) {
    
    }

}

