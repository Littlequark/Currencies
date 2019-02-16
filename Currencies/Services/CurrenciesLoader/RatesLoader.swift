//
//  CurrenciesLoader.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

class RatesLoader: RatesLoaderProtocol {
    
    var delegate: RatesLoaderDelegate?
    var networkClient: NetworkClientProtocol?

    func loadRates() {
        networkClient?.performRequrest(.lastest, methodParams: ["base":"EUR"], completion: { (data, error) in
            if data != nil {
                if let rates = self.rates(from: data!) {
                    self.delegate?.loader(self, didLoadRates:rates)
                }
            }
            else if error != nil {
                self.delegate?.loader(self, didReceiveError: error!)
            }
        })
    }
    
    //FIXME: - move to specific response serializer
    private func rates(from data:Data!) -> [Rate]? {
        var rates:[Rate]?
        if let ratesListDTO = parseRatesListData(responseData: data!) {
            rates = ratesFromList(ratesListDTO: ratesListDTO)
        }
        return rates
    }
    
    private func parseRatesListData(responseData: Data!) -> RatesListDTO? {
        var ratesListDTO:RatesListDTO?
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            ratesListDTO = try decoder.decode(RatesListDTO.self, from: responseData!) }
        catch DecodingError.keyNotFound(let key, let context) {
            print("Missing key: \(key)")
            print("Debug description: \(context.debugDescription)")
        }
        catch DecodingError.valueNotFound(let type, let context) {
            print("Missing value: \(type)")
            print("Debug description: \(context.debugDescription)")
        }
        catch DecodingError.typeMismatch(let key, let context) {
            print("Type mismatch: \(key)")
            print("Debug description: \(context.debugDescription)")
        }
        catch {
            print("Unknown error")
        }
        return ratesListDTO
    }
    
    private func ratesFromList(ratesListDTO: RatesListDTO!) -> [Rate] {
        var rates = [Rate]()
        let relatedCurrency = Currency(identifier:ratesListDTO.base)
        for (key, value) in ratesListDTO.rates {
            let currency = Currency(identifier:key)
            let rate = Rate(currency:currency, coefficient: value, relatedCurrency:relatedCurrency)
            rates.append(rate)
        }
        return rates
    }
    
}
