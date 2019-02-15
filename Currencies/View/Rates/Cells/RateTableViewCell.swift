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
    @IBOutlet var rateTextField:UITextField?
    
    //MARK: - ConfigurableCellProtocol
    
    override var viewModel:CollectionItemViewModel? {
        didSet {
            if let rateViewModel = viewModel as? RateCellViewModelProtocol {
                currencyIdentifierLabel?.text = rateViewModel.currencyIdentifier
                rateTextField?.text = rateViewModel.rate
            }
        }
    }
    
    //MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateTextField?.isUserInteractionEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        rateTextField?.isUserInteractionEnabled = selected
        if selected {
            rateTextField?.becomeFirstResponder()
        }
        else {
            rateTextField?.resignFirstResponder()
        }
    }

}
