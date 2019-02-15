//
//  ItemTableViewCell.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell, ConfigurableCellProtocol, ReusableCellProtocol {

    
    //MARK: - ReusableCellProtocol
    
    static var reuseIdentifier: String {
        return String(describing:self)
    }
    
    static var cellNib:UINib {
        return UINib(nibName:reuseIdentifier, bundle:Bundle(for:self))
    }
    
    //MARK: - ConfigurableCellProtocol
    
    var viewModel: CollectionItemViewModel? {
        didSet {
            //no-op
        }
    }

}
