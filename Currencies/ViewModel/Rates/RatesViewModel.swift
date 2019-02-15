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
            countRate = model?.baseRate
        }
    }
    
    override func item(at indexPath: IndexPath) -> CollectionItemProtocol? {
        guard let item = dataSource?.item(at:indexPath) else {
            return nil
        }
        let viewModel = RateCellViewModel(with:item)
        viewModel.countItem = countRate
        viewModel.countAmount = currencyAmount
        return viewModel
    }
    
    override func loadData() {
        model?.loadRates()
    }
    
    //MARK: - Override
    
    override func dataSourceDidReloadData(dataSource: DataSourceProtocol) {
        if (selectedIndexPaths.count > 0) {
            let indexPaths = dataSource.allIndexPaths()
            let indexPathsToReload = indexPaths.filter {
                return !selectedIndexPaths.contains($0)
            }
            delegate?.viewModel(self, didRefreshItemsAt: indexPathsToReload)
        }
        else {
            delegate?.viewModelDidReloadData(self)
        }
    }
    
    //MARK: - RatesViewModelProtocol
    
    var selectedIndexPaths = [IndexPath]()
    
    var title:String? {
        return NSLocalizedString("Rates", comment: "")
    }
    
    func didChange(rate: Rate, with moneyAmount: Double) {
        selectedIndexPaths.removeAll()
        if let indexPath = dataSource?.indexPaths(for: rate).first {
            countRate = rate
            currencyAmount = moneyAmount
            selectedIndexPaths = [indexPath]
//            delegate?.viewModelDidReloadData(self)
        }
    }
    
    func didChangeRate(at indexPath:IndexPath, with moneyAmount:Double) {
        selectedIndexPaths.removeAll()
        if let rate = dataSource?.item(at:indexPath) as? Rate {
            countRate = rate
            currencyAmount = moneyAmount
            selectedIndexPaths = [indexPath]
        }
    }
    
    private var countRate:Rate?
    private var currencyAmount = Double(1.0)
    
}
