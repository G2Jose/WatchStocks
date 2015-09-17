//
//  Parameters.swift
//  Demo
//
//  Created by George Jose on 2015-09-13.
//  Copyright © 2015 George Jose. All rights reserved.
//

import Foundation
class Parameters{
//    static var baseURL: String = "http://192.168.0.18:3000/scrape?q="
    static var baseURL: String = "http://52.3.141.225:443/scrape?q="

    static var debug: Int = 0
    
    
    static var myStocks: [String: [String:Double]] = [
        "AAPL+NASDAQ": [
            "buyPrice": 131.73,
            "quantity": 17,
            "commission":6.95
        ],
        "WSP+Toronto": [
            "buyPrice": 37.89,
            "quantity": 59,
            "commission":6.95
        ],
        "CNR+TSX": [
            "buyPrice": 74.65,
            "quantity": 17,
            "commission":6.95
        ],
        "Algonquin+Power": [
            "buyPrice": 9.31,
            "quantity": 80,
            "commission":6.95
        ],
        "BTB.UN": [
            "buyPrice": 4.52,
            "quantity": 167,
            "commission":6.95
        ],
        "altagas+tsx": [
            "buyPrice": 35.57,
            "quantity": 43,
            "commission":6.95
        ],
        "GIB.A": [
            "buyPrice": 47.93,
            "quantity": 24,
            "commission":6.95
        ]
    ]
    
}