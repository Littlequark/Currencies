//
//  RateCellViewModel.swift
//  Currencies
//
//  Created by tstepanov on 15/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

class RatecellViewModel: CollectionItemViewModel, RateCellViewModelProtocol {
    
    //MARK: - RateCellViewModelProtocol
    
    var currencyIdentifier: String? {
        get {
            var currencyInfo:String?
            if let currencyId = rateItem?.currency.identifier {
            let countryInfos = IsoCountryCodes.searchByCurrency(currency:currencyId)
            if let countryInfo = countryInfos.first {
                currencyInfo = "\(countryInfo.flag) \(countryInfo.currency)"
                }
            }
            return currencyInfo
        }
    }
    
    var rate:String? {
        get {
            var rateValue:String?
            if rateItem != nil {
                rateValue = String(describing:rateItem!.coefficient)
            }
            return rateValue
        }
    }
    
    private var rateItem: Rate?
    
    required init(with dataItem: Any) {
        if let rateDataItem = dataItem as? Rate {
            rateItem = rateDataItem
        }
        super.init(with: dataItem)
    }
    
}
