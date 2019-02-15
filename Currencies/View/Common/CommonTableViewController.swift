//
//  CommonTableViewController.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

class CommonTableViewController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
CollectionViewModelDelegate {
    
    @IBOutlet var tableView:UITableView? {
        willSet {
            guard tableView != nil else {
                return
            }
            tableView!.delegate = nil
            tableView!.dataSource = nil
        }
        didSet {
            guard tableView != nil else {
                return
            }
            tableView!.delegate = self
            tableView!.dataSource = self
            view.addSubview(tableView!)
            tableView!.translatesAutoresizingMaskIntoConstraints = false
            let viewsAutoLayoutBinding = ["tableView":tableView!] as [String : Any]
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|",
                                                               options: .directionLeadingToTrailing,
                                                               metrics: nil,
                                                               views: viewsAutoLayoutBinding))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
                                                               options: .directionLeadingToTrailing,
                                                               metrics: nil,
                                                               views: viewsAutoLayoutBinding))
            tableView!.tableFooterView = UIView()
            tableView!.rowHeight = UITableView.automaticDimension
            tableView!.estimatedRowHeight = CGFloat(72.0)
        }
    }
    
    var viewModel:CollectionViewModelProtocol? {
        willSet {
            viewModel?.delegate = nil
        }
        didSet {
            viewModel?.delegate = self
        }
    }
    
    private var viewModelToCellMapping = [String:String]()
    
    //MARK: - UIViewController lifecycle
    
    override func loadView() {
        super.loadView()
        // If tableView does not created from interface builder
        if tableView == nil {
            tableView = UITableView(frame:view.bounds, style:.plain)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadData()
    }
    
    //MARK: - Register Methods
    
    func registerCell(with cellIdentifier:String, forViewModelWith viewModelIdentifier:String) {
        viewModelToCellMapping[viewModelIdentifier] = cellIdentifier
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfItemsInsection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //FIXME: implement load cell
        var cell = UITableViewCell()
            if let cellIdentifier = reuseIdentifier(at: indexPath),
            let itemCell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for:indexPath) as? ItemTableViewCell {
            update(cell:itemCell, withViewModelAt:indexPath)
            cell = itemCell
        }
        return cell
    }
    
    //MARK: - CollectionViewModelDelegate
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, didInsertItemsAt indexPaths: [IndexPath]) {
        if isViewLoaded {
            tableView?.insertRows(at:indexPaths, with:.none)
        }
    }
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, didRemoveItemsAt indexPaths: [IndexPath]) {
        if isViewLoaded {
            tableView?.deleteRows(at: indexPaths, with: .left)
        }
    }
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, didRefreshItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, didMoveItemFrom fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        if isViewLoaded {
            tableView?.moveRow(at:fromIndexPath, to: toIndexPath)
        }
    }
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, didInsert sections: IndexSet) {
        if isViewLoaded {
            tableView?.insertSections(sections, with:.none)
        }
    }
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, didRemove sections: IndexSet) {
        if isViewLoaded {
            tableView?.deleteSections(sections, with:.left)
        }
    }
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, didRefresh sections: IndexSet) {
        if isViewLoaded {
            tableView?.reloadSections(sections, with:.none)
        }
    }
    
    func viewModelDidReloadData(_ viewModel: CollectionViewModelProtocol) {
        if isViewLoaded {
            tableView?.reloadData()
        }
    }
    
    func viewModel(_ viewModel: CollectionViewModelProtocol, perform batchUpdate: (() -> ())?, with completion: (() -> ())?) {
        if isViewLoaded {
            tableView?.performBatchUpdates(batchUpdate) { (finished) in
                completion?()
            }
        }
    }
    
    //MARK: - Private
    
    private func update(cell:ItemTableViewCell, withViewModelAt indexPath:IndexPath) {
        cell.viewModel = viewModel?.item(at:indexPath) as? CollectionItemViewModel
        if tableView!.rowHeight == UITableView.automaticDimension {
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
        }
    }
    
    private func reuseIdentifier(at indexPath:IndexPath) -> String? {
        var reuseIdentifier:String?
        if let cellViewModel = viewModel?.item(at: indexPath) {
            reuseIdentifier = viewModelToCellMapping[cellViewModel.identify()]
        }
        return reuseIdentifier
    }
    
}
