//
//  RateTableViewCell.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

class RateTableViewCell: ItemTableViewCell {
    
    @IBOutlet var currencyIdentifierLabel:UILabel?
    @IBOutlet var rateLabel:UILabel?
    
    //MARK: - ConfigurableCellProtocol
    
    override var viewModel:CollectionItemViewModel? {
        didSet {
            if let rateViewModel = viewModel as? RateCellViewModelProtocol {
                currencyIdentifierLabel?.text = rateViewModel.currencyIdentifier
                rateLabel?.text = rateViewModel.rate
            }
        }
    }

}
