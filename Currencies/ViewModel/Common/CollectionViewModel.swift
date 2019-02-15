//
//  CollectionViewModel.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol DataInitializable {
    
    init(with dataItem:Any)

}



class CollectionViewModel:CollectionViewModelProtocol, DataSourceDelegate {
    
    var delegate:CollectionViewModelDelegate?
    var dataSource:DataSourceProtocol? {
        willSet {
            dataSource?.delegate = nil
        }
        didSet {
            dataSource?.delegate = self
        }
    }
    
    //MARK: - CollectionViewModelProtocol
    
    func loadData() {
        //no-op
    }
    
    func numberOfSections() -> Int {
        return dataSource?.numberOfSections ?? 0
    }
    
    func numberOfItemsInsection(_ section: Int) -> Int {
        return dataSource?.numberOfItems(in: section) ?? 0
    }
    
    func item(at indexPath: IndexPath) -> CollectionItemProtocol? {
        guard let dataItem = dataSource?.item(at:indexPath) else {
            return nil
        }
        return CollectionItemViewModel(with: dataItem)
    }
    
    func titleForSection(_ section: Int) -> String? {
        return nil
    }
    
    //MARK: - DataSourceDelegate
    
    func dataSourceDidReloadData(dataSource: DataSourceProtocol) {
        delegate?.viewModelDidReloadData(self)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didInsertItemsAt indexPaths: [IndexPath]) {
        delegate?.viewModel(self, didInsertItemsAt: indexPaths)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didRemoveItemsAt indexPaths: [IndexPath]) {
        delegate?.viewModel(self, didRemoveItemsAt: indexPaths)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didRefreshItemsAt indexPaths: [IndexPath]) {
        delegate?.viewModel(self, didRefreshItemsAt: indexPaths)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didMoveItemFrom fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        delegate?.viewModel(self, didMoveItemFrom: fromIndexPath, to: toIndexPath)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didInsert sections: IndexSet) {
        delegate?.viewModel(self, didInsert: sections)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didRemove sections: IndexSet) {
        delegate?.viewModel(self, didRemove: sections)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didRefresh sections: IndexSet) {
        delegate?.viewModel(self, didRefresh: sections)
    }
    
    func dataSource(dataSource: DataSourceProtocol, perform batchUpdate: DataSourceUpdateBlock?, completion: DataSourceUpdateBlock?) {
        delegate?.viewModel(self, perform: batchUpdate, with: completion)
    }
    
    func dataSource(dataSource: DataSourceProtocol, didLoadContentWith error: Error) {
        // No operation
    }
    
    func dataSourceWillLoadContent(dataSource: DataSourceProtocol) {
        // No operation
    }
    
}
