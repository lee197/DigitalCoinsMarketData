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
    
    
     mutating func dataFetchFailed(errorString:String)
    
}


 struct NetworkingClient {
    
     var delegate: NetworkManagerDelegate?

    //request data and return the results by delegate
    mutating func requestData(){
        
        var mutateDelegate = delegate

        dataProvider.request(.data) { result in

            switch result
                
            {
            case let .success(response):
                do {
                    
                    let data = try response.mapJSON()
                    
                    let digital_Coin_Model_Array =  Mapper<DigitalCoinViewModelData>().map(JSON: data as! [String : Any])!
                    
                    mutateDelegate?.didReceiveData(digital_Coin_Model: digital_Coin_Model_Array.data!)
                    
                    return
                    
                }catch {
                    
                    mutateDelegate?.dataFetchFailed(errorString: "Internet Error, please try again")

                    return
                    
                }
                
            case let .failure(error):
                
                guard let errorString =  error.errorDescription else {

                    mutateDelegate?.dataFetchFailed(errorString:"Internet Error, please try again")

                    return

                }
                // leave this print for debugging
                print(errorString)
                
                mutateDelegate?.dataFetchFailed(errorString: "Internet Error, please try again")
                break
                
            }
            
        }
        
    }


    
}


