//
//  DataSourceProtocol.swift
//  Currencies
//
//  Created by tstepanov on 05/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

typealias DataSourceUpdateBlock = ()->()


protocol DataSourceProtocol {
    
    var delegate:DataSourceDelegate? { get set }
    
    var items:[Any] { get set }
    
    var numberOfSections:Int { get }
    
    func numberOfItems(in section:Int) -> Int
    
    func item(at indexPath:IndexPath) -> Any?
    
    func indexPaths(for item:Any) -> [IndexPath]
    
    func allIndexPaths() -> [IndexPath]
    
    // Use these methods to notify the collection view of changes to the dataSource.
    func notifyItemsInserted(at insertedIndexPaths:[IndexPath])
    func notifyItemsRemoved(at removedIndexPaths:[IndexPath])
    func notifyItemsRefreshed(at refreshedIndexPaths:[IndexPath])
    func notifyItemMoved(from fromIndexPath:IndexPath, to newIndexPath:IndexPath)
    
    func notifySectionsInserted(sections:IndexSet)
    func notifySectionsRemoved(sections:IndexSet)
    func notifySectionsRefreshed(sections:IndexSet)

    func notifyDidReloadData()

    func notifyBatchUpdate(update:DataSourceUpdateBlock?);
    func notifyBatchUpdate(update:DataSourceUpdateBlock?, completion:DataSourceUpdateBlock?)

}
