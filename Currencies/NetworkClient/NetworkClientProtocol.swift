//
//  NetworkClientProtocol.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

typealias NetworkClientCompletionBlock = (_ response:Data?, _ error:Error?) -> Void

enum ApiEndpoint:String {
    case lastest = "/latest"
}

protocol NetworkClientProtocol: class {

    func performRequrest(_ endpoint:ApiEndpoint,
                         methodParams:[String:String]?,
                         completion: NetworkClientCompletionBlock?)
    
    func performRequrest(_ endpoint:ApiEndpoint,
                         methodParams:[String:String]?,
                         callBackQueue:DispatchQueue,
                         completion: NetworkClientCompletionBlock?)
    
}

