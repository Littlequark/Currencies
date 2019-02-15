//
//  DataSource.swift
//  Currencies
//
//  Created by tstepanov on 05/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func insertMany(additions:[Element], at indexes:IndexSet) {
        guard additions.count == indexes.count else {
            return
        }
        var indexItrerator = indexes.makeIterator()
        var currentIndex = indexItrerator.next()
        for addition in additions {
            insert(addition, at:currentIndex!)
            currentIndex = indexItrerator.next()
        }
    }
    
    mutating func replaceMany(replacements:[Element], at indexes:IndexSet) {
        guard replacements.count == indexes.count else {
            return
        }
        var indexItrerator = indexes.makeIterator()
        var currentIndex = indexItrerator.next()
        for replacement in replacements {
            let subrange:Range = currentIndex!..<currentIndex!+1
            replaceSubrange(subrange, with:[replacement])
            currentIndex = indexItrerator.next()
        }
    }
    
}

class DataSource<T:Equatable>: DataSourceProtocol {
    
    var delegate:DataSourceDelegate?
    
    private var _items = [T]()
    
    var items:[Any] {
        set {
            _items = newValue as! [T]
           notifyDidReloadData()
        }
        get {
            return _items
        }
    }

    var numberOfSections: Int {
        ////AssertionOnMainThread
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        ////AssertionOnMainThread
        return self.items.count
    }
    
    func item(at indexPath: IndexPath) -> Any? {
        ////AssertionOnMainThread
        var item:T?
        if (indexPath.item < items.count) {
            item = items[indexPath.item] as? T
        }
        return item
    }
    
    func indexPaths(for item: Any) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        if let equatableItem = item as? T {
            for index in 0..<items.count {
                let containedIdem = items[index] as? T
                if containedIdem == equatableItem {
                    indexPaths.append(IndexPath(item: index, section: 0))
                }
            }
        }
        return indexPaths
    }
    
    
    func allIndexPaths() -> [IndexPath] {
        var indexPaths = [IndexPath]()
        for section in 0..<numberOfSections {
            for item in 0..<numberOfItems(in: section) {
                indexPaths.append(IndexPath(item: item, section: section))
            }
        }
        return indexPaths
    }
    
    //MARK: - Items methods
    
    func insert(itemsToInsert:[T], at indexes:IndexSet) {
        ////AssertionOnMainThread
        _items.insertMany(additions:itemsToInsert, at:indexes)
        let insertedIndexPaths = indexes.map { (index) -> IndexPath in
            return IndexPath(item: index, section: 0)
        }
        notifyBatchUpdate {
            self.notifyItemsInserted(at: insertedIndexPaths)
        }
    }
    
    func removeItems(at indexes:IndexSet) {
        ////AssertionOnMainThread
        var newItems = [T]()
        var batchUpdates = { ()->() in  }
        
        for oldIndex in 0..<_items.count {
            let oldUpdates = batchUpdates
            if indexes.contains(oldIndex) {
                // Item will not be included in new items array
                // Means literally will be removed from old array
                batchUpdates = { () -> () in
                    oldUpdates()
                    self.notifyItemsRemoved(at: [IndexPath(item: oldIndex, section: 0)])
                }
            }
            else {
                // Item is kept into new array
                let newIndex = newItems.count
                let item = _items[oldIndex]
                newItems.append(item)
                if newIndex != oldIndex {
                    batchUpdates = { ()->() in
                        oldUpdates()
                        self.notifyItemMoved(from: IndexPath(item: oldIndex, section: 0),
                                             to: IndexPath(item: newIndex, section: 0))
                    }
                }
            }
        }
        _items = newItems
        notifyBatchUpdate(update:batchUpdates)
    }

    func replaceItems(at indexes:IndexSet, with replacingItems:[T]) {
        ////AssertionOnMainThread
        _items .replaceMany(replacements:replacingItems, at:indexes)
        let replacedIndexPaths = indexes.map { (index) -> IndexPath in
            return IndexPath(item: index, section: 0)
        }
        notifyBatchUpdate {
            self.notifyItemsInserted(at: replacedIndexPaths)
        }
    }
    
    
    
    //MARK: - Public notifications
    
    func notifyItemsInserted(at insertedIndexPaths: [IndexPath]) {
        ////AssertionOnMainThread
        delegate?.dataSource(dataSource:self, didInsertItemsAt:insertedIndexPaths)
    }
    
    func notifyItemsRemoved(at removedIndexPaths: [IndexPath]) {
        ////AssertionOnMainThread
        delegate?.dataSource(dataSource:self, didRemoveItemsAt:removedIndexPaths)
    }
    
    func notifyItemsRefreshed(at refreshedIndexPaths: [IndexPath]) {
        ////AssertionOnMainThread
        delegate?.dataSource(dataSource:self, didRefreshItemsAt:refreshedIndexPaths)
    }
    
    func notifyItemMoved(from fromIndexPath: IndexPath, to newIndexPath: IndexPath) {
        ////AssertionOnMainThread
        delegate?.dataSource(dataSource:self, didMoveItemFrom:fromIndexPath, to:newIndexPath)
    }
    
    func notifySectionsInserted(sections: IndexSet) {
        ////AssertionOnMainThread
        delegate?.dataSource(dataSource:self, didInsert:sections)
    }
    
    func notifySectionsRemoved(sections: IndexSet) {
        ////AssertionOnMainThread
        delegate?.dataSource(dataSource:self, didRemove:sections)
    }
    
    func notifySectionsRefreshed(sections: IndexSet) {
        ////AssertionOnMainThread
        delegate?.dataSource(dataSource:self, didRefresh:sections)
    }
    
    func notifyDidReloadData() {
        ////AssertionOnMainThread
        delegate?.dataSourceDidReloadData(dataSource:self)
    }
    
    func notifyBatchUpdate(update: DataSourceUpdateBlock?) {
        ////AssertionOnMainThread
        notifyBatchUpdate(update:update, completion:nil)
    }
    
    func notifyBatchUpdate(update: DataSourceUpdateBlock?, completion: DataSourceUpdateBlock?) {
        if delegate != nil {
            delegate!.dataSource(dataSource:self, perform:update, completion:completion)
        }
        else {
            update?()
            completion?()
        }
    }
    
}
