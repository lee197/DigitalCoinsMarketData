//
//  NetworkingClient.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//


import Foundation
import ObjectMapper


 protocol NetworkManagerDelegate {
    
     mutating func didReceiveData(digital_Coin_Model:[DigitalCoinModel])
    
     mutating func dataCanNotConvert(errorString:String)
    
     mutating func dataFetchFailed(errorString:String)
    
}


 struct NetworkingClient {
    
    var delegate: NetworkManagerDelegate?

    
    mutating func requestData(){
        
        var mutateDelegate = delegate

        dataProvider.request(.data) { result in

            switch result
                
            {
            case let .success(response):
                do {
                    
                    let data = try response.mapJSON()
                    
                    let digital_Coin_Model_Array = try Mapper<DigitalCoinViewModelData>().map(JSON: data as! [String : Any])!
                    
                    mutateDelegate?.didReceiveData(digital_Coin_Model: digital_Coin_Model_Array.data!)
                    return
                    
                }catch {
                    
                    mutateDelegate?.dataCanNotConvert(errorString: "Internet Error, please try again")
                    
                    return
                    
                }
                
            case let .failure(error):
                
                guard let errorString =  error.errorDescription else {

                    mutateDelegate?.dataFetchFailed(errorString:"Internet Error, please try again")

                    return

                }

                mutateDelegate?.dataFetchFailed(errorString: errorString)
                break
                
            }
            
            
            
        }
        
        
    }


    
}


