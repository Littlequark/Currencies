//
//  RateTableViewCell.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

class RateTableViewCell: ItemTableViewCell, UITextFieldDelegate {
    
    @IBOutlet var currencyIdentifierLabel:UILabel?
    @IBOutlet var rateTextField:UITextField? {
        didSet {
            rateTextField?.delegate = self
        }
    }
    
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
    
    //MARK: - UITextFielDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text,
            let responder = findResponder() as? RateChangingProtocol {
            let amount = Double(text)
            responder.didChange(rate:viewModel as Any, with: amount!)
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let  text = textField.text,
            let swiftRange = Range(range, in: text),
            let responder = findResponder() as? RateChangingProtocol {
            let result = text.replacingCharacters(in: swiftRange, with: string)
            if let amount = Double(result) {
                responder.didChange(rate:viewModel as Any, with: amount)
            }
        }
        return true
    }
    
    func findResponder () -> UIResponder? {
        var rateChangeResponder:UIResponder?
        var responderToCheck = self.next
        while responderToCheck != nil {
            if responderToCheck!.responds(to:#selector(RateChangingProtocol.didChange(rate:with:))) {
                rateChangeResponder = responderToCheck
                break
            }
            else {
                responderToCheck = responderToCheck!.next
            }
        }
        return rateChangeResponder
    }
}
