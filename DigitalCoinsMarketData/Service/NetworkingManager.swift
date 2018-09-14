//
//  NetworkingManager.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import Foundation
import Moya
import Alamofire

let dataProvider = MoyaProvider<NetworkingManager>(manager: DefaultAlamofireManager.sharedManager)

//set the connection timeout--- 10 seconds
class DefaultAlamofireManager: Alamofire.SessionManager {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}



enum NetworkingManager {
    
    case data
    
}

// MARK: - TargetType Protocol Implementation
extension NetworkingManager: TargetType {
    
    //specify the url
    
    var baseURL: URL { return URL(string: "https://www.binance.com/")! }
    
    
    var path: String {
        
        switch self {
            
        case .data:
            return "/exchange/public/product"
            
            
            
            
        }
    }
    
    //specified the method
    var method: Moya.Method {
        switch self {
        case .data:
            return .get
            
        }
    }
    //include the parameters
    var task: Task {
        
        switch self {
            
        case .data:
            
            return .requestPlain
            
        }
    }
    // this sample data is used for test
    var sampleData: Data {
        switch self {
            
        case .data:
            
            // this is the data for testing, in the product version, this data can not be put here
            return "{\"data\":[{\"symbol\":\"NULSBNB\",\"quoteAssetName\":\"Binance Coin\",\"tradedMoney\":1047.804465,\"baseAssetUnit\":\"\",\"baseAssetName\":\"Nuls\",\"baseAsset\":\"NULS\",\"tickSize\":\"0.00001\",\"prevClose\":0.12514,\"activeBuy\":0.0,\"high\":\"0.13124\",\"lastAggTradeId\":-1,\"low\":\"0.11630\",\"matchingUnitType\":\"STANDARD\",\"close\":\"0.11630\",\"quoteAsset\":\"BNB\",\"productType\":null,\"active\":true,\"minTrade\":0.10000000,\"activeSell\":8518.1,\"withdrawFee\":\"0\",\"volume\":\"8518.10000\",\"decimalPlaces\":8,\"quoteAssetUnit\":\"\",\"open\":\"0.12514\",\"status\":\"TRADING\",\"minQty\":1E-8},{\"symbol\":\"BNBBTC\",\"quoteAssetName\":\"Bitcoin\",\"tradedMoney\":1838.95934843,\"baseAssetUnit\":\"\",\"baseAssetName\":\"Binance Coin\",\"baseAsset\":\"BNB\",\"tickSize\":\"0.0000001\",\"prevClose\":0.0014771,\"activeBuy\":0.0,\"high\":\"0.0015252\",\"lastAggTradeId\":-1,\"low\":\"0.0014548\",\"matchingUnitType\":\"STANDARD\",\"close\":\"0.0015018\",\"quoteAsset\":\"BTC\",\"productType\":null,\"active\":true,\"minTrade\":0.01000000,\"activeSell\":1236675.92,\"withdrawFee\":\"0\",\"volume\":\"1236675.9200000\",\"decimalPlaces\":8,\"quoteAssetUnit\":\"฿\",\"open\":\"0.0014771\",\"status\":\"TRADING\",\"minQty\":1E-8}]}".utf8Encoded
            
        }
    }
    
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
