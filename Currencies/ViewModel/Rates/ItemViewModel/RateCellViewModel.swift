//
//  RateCellViewModel.swift
//  Currencies
//
//  Created by tstepanov on 15/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

class RateCellViewModel: CollectionItemViewModel, RateCellViewModelProtocol {
    
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
            return String(describing:cellCurrencyAmount())
        }
    }
    
    //MARK: - Public interface
    
    var countItem:Rate?
    var countAmount:Double?
    
    //MARK: - Private
    
    private var rateItem: Rate?
    
    private func cellCurrencyAmount() -> Double {
        var moneyAmount = Double(0)
        if rateItem != nil {
            if countAmount != nil,
                countItem != nil,
                rateItem != countItem {
                moneyAmount = countAmount! * rateItem!.coefficient / countItem!.coefficient
            }
            else {
                moneyAmount = rateItem!.coefficient
            }
        }
        return round(moneyAmount * 100.0)/100.0
    }
    
    required init(with dataItem: Any) {
        if let rateDataItem = dataItem as? Rate {
            rateItem = rateDataItem
        }
        super.init(with: dataItem)
    }
    
}
