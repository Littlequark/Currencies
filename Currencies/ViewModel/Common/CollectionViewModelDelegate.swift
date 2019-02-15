//
//  CollectionViewModelDelegate.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol CollectionViewModelDelegate  {
    
    func viewModel(_ viewModel:CollectionViewModelProtocol, didInsertItemsAt indexPaths:[IndexPath])
    func viewModel(_ viewModel:CollectionViewModelProtocol, didRemoveItemsAt indexPaths:[IndexPath])
    func viewModel(_ viewModel:CollectionViewModelProtocol, didRefreshItemsAt indexPaths:[IndexPath])
    func viewModel(_ viewModel:CollectionViewModelProtocol, didMoveItemFrom fromIndexPath:IndexPath, to toIndexPath:IndexPath)
    
    func viewModel(_ viewModel:CollectionViewModelProtocol, didInsert sections:IndexSet)
    func viewModel(_ viewModel:CollectionViewModelProtocol, didRemove sections:IndexSet)
    func viewModel(_ viewModel:CollectionViewModelProtocol, didRefresh sections:IndexSet)
    
    func viewModelDidReloadData(_ viewModel:CollectionViewModelProtocol)
    func viewModel(_ viewModel:CollectionViewModelProtocol, perform batchUpdate:(()->())?, with completion:(()->())?)
    
}
