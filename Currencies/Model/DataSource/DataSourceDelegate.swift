//
//  DataSourceDelegate.swift
//  Currencies
//
//  Created by tstepanov on 05/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol DataSourceDelegate {
    
    func dataSource(dataSource:DataSourceProtocol, didInsertItemsAt indexPaths:[IndexPath])
    func dataSource(dataSource:DataSourceProtocol, didRemoveItemsAt indexPaths:[IndexPath])
    func dataSource(dataSource:DataSourceProtocol, didRefreshItemsAt indexPaths:[IndexPath])
    func dataSource(dataSource:DataSourceProtocol, didMoveItemFrom fromIndexPath:IndexPath, to toIndexPath:IndexPath)
    
    func dataSource(dataSource:DataSourceProtocol, didInsert sections:IndexSet)
    func dataSource(dataSource:DataSourceProtocol, didRemove sections:IndexSet)
    func dataSource(dataSource:DataSourceProtocol, didRefresh sections:IndexSet)
    
    func dataSourceDidReloadData(dataSource:DataSourceProtocol)
    
    func dataSource(dataSource:DataSourceProtocol, perform batchUpdate:DataSourceUpdateBlock?, completion:DataSourceUpdateBlock?)
    
    /// If the content was loaded successfully, the error will be nil.
    func dataSource(dataSource:DataSourceProtocol, didLoadContentWith error:Error)
    
    /// Called just before a datasource begins loading its content.
    func dataSourceWillLoadContent(dataSource:DataSourceProtocol)
    
}
