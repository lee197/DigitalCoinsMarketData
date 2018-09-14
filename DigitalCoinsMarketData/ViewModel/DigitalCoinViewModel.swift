//
//  DIgitalCoinViewModel.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import Foundation


protocol NetworkingResultDelegate:NSObjectProtocol {
    
func sendSuccessResult(digital_Coin_TableViewModel:[DigitalCoinTableViewModel])
func remindUserConnectionError(errorString:String)

    
    }


class DigitalCoinViewModel:NetworkManagerDelegate{
  
   weak var delegate: NetworkingResultDelegate?
    
    var digitalCoinDataArray:[DigitalCoinModel]=[]
    
    
    
    /**
     
     request the data from API
     
     - parameter: Void
     
     - returns: Void
     
     */
     func requestNetworkingData(){
    
        var networkingClient = NetworkingClient()
        networkingClient.delegate = self
        networkingClient.requestData()
    
    }
    
    
    /**
     
     receive the data from API
     
     - parameter: digital_Coin_Model is the data format from API
     
     - returns: Void
     
     */
    
    func didReceiveData(digital_Coin_Model: [DigitalCoinModel]) {
        
        self.digitalCoinDataArray=digital_Coin_Model
        
        self.delegate?.sendSuccessResult(digital_Coin_TableViewModel:
            self.classifyModel(digital_Coin_Model:digital_Coin_Model))
        
            }
    /**

     Arrange the model data to different TableViewModels for Tabcontroller to use
     
     - parameter: [DigitalCoinModel], digital_Coin_Model is the data format from API
     
     - returns: [DigitalCoinTableViewModel]
     
     */
    
    func classifyModel(digital_Coin_Model:[DigitalCoinModel])->[DigitalCoinTableViewModel]{
        
        var bnbDigitalCoinModelArray:[DigitalCoinModel] = []
        var btcDigitalCoinModelArray:[DigitalCoinModel] = []
        var usdtDigitalCoinModelArray:[DigitalCoinModel] = []
        var ethigDigitalCoinModelArray:[DigitalCoinModel] = []

        var digitalCoinTableViewModelArray:[DigitalCoinTableViewModel] = []
        
        for item in digital_Coin_Model{
            
            switch item.quoteAsset{
                
           case "BNB":
                    
                bnbDigitalCoinModelArray.append(item)
            case "BTC":
                
                btcDigitalCoinModelArray.append(item)
                
            case "ETH":
                
                ethigDigitalCoinModelArray.append(item)
                
            default:
                usdtDigitalCoinModelArray.append(item)

            }
            
        }
        
        let bnbDigitalCoinViewModel=DigitalCoinTableViewModel(digitalCoinDataArray: bnbDigitalCoinModelArray)
        
        let btcDigitalCoinViewModel=DigitalCoinTableViewModel(digitalCoinDataArray: btcDigitalCoinModelArray)
        
        let ethDigitalCoinViewModel=DigitalCoinTableViewModel(digitalCoinDataArray: ethigDigitalCoinModelArray)
        
        let usdtDigitalCoinViewModel=DigitalCoinTableViewModel(digitalCoinDataArray: usdtDigitalCoinModelArray)
        
        digitalCoinTableViewModelArray.append(bnbDigitalCoinViewModel)
        digitalCoinTableViewModelArray.append(btcDigitalCoinViewModel)
        digitalCoinTableViewModelArray.append(ethDigitalCoinViewModel)
        digitalCoinTableViewModelArray.append(usdtDigitalCoinViewModel)

        return digitalCoinTableViewModelArray
        
    }
    
    
    /**
     
     Receiving the searching keywords to get the correct search results
     
     - parameter: searchWords:the keywords for searching, completion:@escaping ([DigitalCoinTableViewModel]?)->() a call back function to pass the requested data to Viewcontroller
     
     - returns: Void
     
     */
    
    func searchByKeywords(searchWords:String,completion:@escaping ([DigitalCoinTableViewModel]?)->()){
    
          let classifiedTableViewModelArray = self.classifyModel(digital_Coin_Model:digitalCoinDataArray)
    
            for item in classifiedTableViewModelArray{
                
                var i = 0
                
                while (i<item.digitalCoinDataArray.count){
                    
                    if item.digitalCoinDataArray[i].baseAsset != searchWords{
                        
                        item.digitalCoinDataArray.remove(at: i)
                        i = i - 1
                        
                    }
                    
                    i = i + 1
                }
                
            }
            
            
            completion(classifiedTableViewModelArray)
    
        }
    
    /**
     
     When the search has been cancelled , return the normal data before search
     
     - parameter: Void
     
     - returns: Void
     
     */
    
    func cancelSearch(){
        
        self.delegate?.sendSuccessResult(digital_Coin_TableViewModel:
            self.classifyModel(digital_Coin_Model:digitalCoinDataArray))
        
    }
    
    /**
     
     When data fetched failed, show proper alert to user
     
     - parameter: the error string about to show to user
     
     - returns: Void
     
     */
    
  
    
    func dataFetchFailed(errorString: String) {
        
        self.delegate?.remindUserConnectionError(errorString: errorString)

        
    }
    
    
    
    
}
