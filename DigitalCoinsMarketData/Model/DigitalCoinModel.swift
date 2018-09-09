//
//  Model.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import Foundation
import ObjectMapper


struct DigitalCoinViewModelData: Mappable {
    var data: [DigitalCoinModel]?
    
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        data  <- map["data"]
     }
}

struct DigitalCoinModel:Mappable {

    
    var symbol: String?
    var quoteAssetName: String?
    var tradedMoney: Double?
    var baseAssetUnit: String?
    var baseAssetName: String?
    var baseAsset: String
    var tickSize: String?
    var prevClose: Double?
    var activeBuy: Int?
    var high: String?
    var lastAggTradeID: Int?
    var low: String?
    var matchingUnitType: String?
    var close: String
    var quoteAsset: String
    var productType: NSNull?
    var active: Bool?
    var minTrade: Double?
    var activeSell: Double?
    var withdrawFee: String?
    var volume: String
    var decimalPlaces: Int?
    var quoteAssetUnit: String?
    var datumOpen: String?
    var status: String?
    var minQty: Double?

    init?(map: Map) {
        
        self.baseAsset = ""
        self.close = ""
        self.quoteAsset = ""
        self.volume = ""
        
    }
    
    mutating func mapping(map: Map) {
        symbol     <- map["symbol"]
        quoteAssetName  <- map["quoteAssetName"]
        tradedMoney     <- map["tradedMoney"]
        baseAssetUnit  <- map["baseAssetUnit"]
        baseAssetName     <- map["baseAssetName"]
        baseAsset  <- map["baseAsset"]
        tickSize     <- map["tickSize"]
        prevClose  <- map["prevClose"]
        
        activeBuy     <- map["activeBuy"]
        high  <- map["high"]
        lastAggTradeID     <- map["lastAggTradeID"]
        low  <- map["low"]
        matchingUnitType     <- map["matchingUnitType"]
        close  <- map["close"]
        quoteAsset     <- map["quoteAsset"]
        productType  <- map["productType"]
        
        active     <- map["active"]
        minTrade  <- map["minTrade"]
        activeSell     <- map["activeSell"]
        withdrawFee  <- map["withdrawFee"]
        matchingUnitType     <- map["matchingUnitType"]
        volume  <- map["volume"]
        decimalPlaces     <- map["decimalPlaces"]
        quoteAssetUnit  <- map["quoteAssetUnit"]

        datumOpen  <- map["datumOpen"]
        status     <- map["status"]
        minQty  <- map["minQty"]
    }

}
