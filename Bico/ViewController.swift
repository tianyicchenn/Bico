//
//  ViewController.swift
//  Bico
//
//  Created by Tianyi on 2020/4/16.
//  Copyright © 2020 Tianyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var exchangeCurrencyLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    func getCurrentTime () -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
    
}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count 
    }
}


//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //get called everyt time user scrolls the picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.getExchangeRate(of: currency)
    }
}

//MARK: - CoinManagerDelegate
extension  ViewController: CoinManagerDelegate {
    func didUpdateRate(exchangRate: String, currency: String) {
        DispatchQueue.main.async {
            self.exchangeRateLabel.text = exchangRate
            self.exchangeCurrencyLabel.text = currency
            self.updateTimeLabel.text = "Last updated: \(self.getCurrentTime())"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
