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
            
            
            return "".utf8Encoded
            
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
