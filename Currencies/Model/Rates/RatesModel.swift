//
//  RatesModel.swift
//  Currencies
//
//  Created by tstepanov on 04/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation


class RatesModel:RatesModelProtocol, RatesLoaderDelegate {
    
    private var objectsPool = [Rate]()
    
    var ratesLoader:RatesLoaderProtocol! {
        didSet {
            ratesLoader.delegate = self
        }
    }
    
    var dataSource:DataSourceProtocol?
    
    //MARK: - RatesModelProtocol
   
    func loadRates() {
        loadData()
        startIfNotRunning()
    }
    
    var baseRate: Rate {
        get {
            return _baseRate
        }
    }

    //MARK: - RatesLoaderDelegate
    
    func loader(_ loader: RatesLoaderProtocol, didLoadRates rates:[Rate]) {
        var moreRates = rates
        moreRates.append(_baseRate)
        moreRates.sort { return $0.currency.identifier < $1.currency.identifier }
        dataSource?.items = moreRates
    }
    
    func loader(_ loader: RatesLoaderProtocol, didReceiveError error: Error) {
        //FIXME: - implement error handling
    }
    
    private let _baseRate = Rate(currency: Currency.euro, coefficient: 1.0, relatedCurrency: Currency.euro)
    
    //MARK: - Private
    
    private var refreshTimer:Timer?
    
    private func startIfNotRunning() {
        if refreshTimer != nil,
            refreshTimer!.isValid {
            stopRefreshTimer()
        }
        startRefreshTimer()
    }
    
    private func startRefreshTimer() {
        refreshTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0),
                                            target: self,
                                            selector: #selector(RatesModel.loadData),
                                            userInfo: nil,
                                            repeats: true)
    }
    
    private func stopRefreshTimer() {
       refreshTimer?.invalidate()
    }
    
    @objc private func loadData() {
        ratesLoader.loadRates()
    }
    
}
