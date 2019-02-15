//
//  RatesListViewController.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

class RatesListViewController: CommonTableViewController {

    private var selectedIndexPaths = [IndexPath]()
    private var selectedCell:UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        title = (viewModel as? RatesViewModelProtocol)?.title
        #if DEBUG
        let refreshBarItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(RatesListViewController.refreshPressed(sender:)))
                navigationItem.rightBarButtonItem = refreshBarItem
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Override of CommonTableViewController
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (viewModel as? RatesViewModelProtocol)!.selectedIndexPaths.contains(indexPath) {
            return selectedCell!
        }
        else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = tableView.cellForRow(at: indexPath)
        (viewModel as? RatesViewModelProtocol)?.didChangeRate(at: indexPath, with:100)
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
        viewModel?.loadData()
    }

}

