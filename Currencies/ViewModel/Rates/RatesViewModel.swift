//
//  RatesViewModel.swift
//  Currencies
//
//  Created by tstepanov on 04/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

struct RateCollectionItem {}

class RatesViewModel:CollectionViewModel, RatesViewModelProtocol {
    
    var model:RatesModelProtocol? {
        didSet {
            guard model != nil  else {
                return
            }
            dataSource = model?.dataSource
        }
    }
    
    override func item(at indexPath: IndexPath) -> CollectionItemProtocol? {
        guard let item = dataSource?.item(at:indexPath) else {
            return nil
        }
        return RatecellViewModel(with:item)
    }
    
    override func loadData() {
        model?.loadRates()
    }
    
    //MARK: - RatesViewModelProtocol
    
    var title:String? {
        return NSLocalizedString("Rates", comment: "")
    }
    
}
