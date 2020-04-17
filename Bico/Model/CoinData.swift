//
//  CoinData.swift
//  Bico
//
//  Created by Tianyi on 2020/4/16.
//  Copyright © 2020 Tianyi. All rights reserved.
//

import Foundation
struct CoinData: Decodable {
    let asset_id_quote: String
    let rate: Double
    
}

/*
"time": "2020-04-16T04:56:45.5372438Z",
"asset_id_base": "BTC",
"asset_id_quote": "USD",
"rate": 6638.852230315639 */
