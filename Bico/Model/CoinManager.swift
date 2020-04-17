//
//  CoinManager.swift
//  Bico
//
//  Created by Tianyi on 2020/4/16.
//  Copyright © 2020 Tianyi. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdateRate(exchangRate: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager{
    
    var delegate: CoinManagerDelegate?
    let baseUrl = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "api-key-from-coinapi.io"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS",
                         "INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK",
                         "SGD","USD","ZAR"]
    
    func getExchangeRate(of currency: String) {
        let completeUrl = "\(baseUrl)/\(currency)?apikey=\(apiKey)"
        
        // perform Requests
        if let url = URL(string: completeUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coinRate = self.parseJSON(safeData) {
                        let rateString = String(format: "%.2f",coinRate)
                        self.delegate?.didUpdateRate(exchangRate: rateString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinData.self, from: coinData)
            return decodeData.rate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
