//
//  RatesListViewController.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

class RatesListViewController: CommonTableViewController, RateChangingProtocol {

    private var selectedIndexPaths = [IndexPath]()
    private var selectedCell:UITableViewCell?
    
    deinit {
        unsubscribeFromNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        title = (viewModel as? RatesViewModelProtocol)?.title
        #if DEBUG
        let refreshBarItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(RatesListViewController.refreshPressed(sender:)))
                navigationItem.rightBarButtonItem = refreshBarItem
        #endif
        subscribeToNotifications()
    }
    
    private var ratesViewModel:RatesViewModelProtocol? {
        return viewModel as? RatesViewModelProtocol
    }
    
    //MARK: - RateChangingProtocol
    
    func didChange(rate: Any, with amount: Double) {
        if rate is RateCellViewModel {
           let rateDataItem = (rate as! RateCellViewModel)._dataItem as! Rate
            ratesViewModel?.didChange(rate: rateDataItem, with: amount)
        }
    }
    
    //MARK: - Override of CommonTableViewController
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (ratesViewModel?.selectedIndexPaths.contains(indexPath) ?? false) {
//            return selectedCell!
//        }
//        else {
//            return super.tableView(tableView, cellForRowAt: indexPath)
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCell == nil  {
            selectedCell = tableView.cellForRow(at: indexPath)
        }
    }
    
    override func viewModel(_ viewModel: CollectionViewModelProtocol, didRefreshItemsAt indexPaths: [IndexPath]) {
        var indexPathsToUpdate = [IndexPath]()
        var indexPathsToReload = [IndexPath]()
        indexPaths.forEach { (indexPath) in
            ratesViewModel!.selectedIndexPaths.contains(indexPath) ?
                indexPathsToUpdate.append(indexPath) :
                indexPathsToReload.append(indexPath)
        }
        updateWithNoReloadRows(at: indexPathsToUpdate)
        super.viewModel(viewModel, didRefreshItemsAt: indexPathsToReload)
    }
    
    //MARK: - Register
    
    private func registerCells() {
        let cellIdentifier = RateTableViewCell.reuseIdentifier
        tableView?.register(NSClassFromString(cellIdentifier), forCellReuseIdentifier:cellIdentifier)
        let nib = RateTableViewCell.cellNib
        tableView?.register(nib, forCellReuseIdentifier:cellIdentifier)
        registerCell(with: cellIdentifier, forViewModelWith:RateCellViewModel.itemIdentifier)
    }
    
    //MARK: - Actions
    
    @IBAction func refreshPressed(sender:AnyObject) {
        viewModel?.loadData()
    }
    
    //MARK: - Notifications
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RatesListViewController.keyboardWillChangeFrame(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillChangeFrame(notification:Notification) {
        if let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect  {
            tableView!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
        }
    }
    
}

