//
//  DIgitalCoinViewModel.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import Foundation


 protocol NetworkingResultDelegate {
    
func sendSuccessResult(digital_Coin_TableViewModel:[DigitalCoinTableViewModel])
func remindUserConnectionError(errorString:String)

    
    }


class DigitalCoinViewModel:NetworkManagerDelegate{
  
    var delegate: NetworkingResultDelegate?
    
    var digitalCoinDataArray:[DigitalCoinModel]=[]
    
     func requestNetworkingData(){
    
        var networkingClient = NetworkingClient()
        networkingClient.delegate = self
        networkingClient.requestData()
    
    }
    
    func didReceiveData(digital_Coin_Model: [DigitalCoinModel]) {
        
        self.digitalCoinDataArray=digital_Coin_Model
        
        self.delegate?.sendSuccessResult(digital_Coin_TableViewModel:
            self.classifyModel(digital_Coin_Model:digital_Coin_Model))
        
            }
    
    
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
    
    func cancelSearch(){
        
        self.delegate?.sendSuccessResult(digital_Coin_TableViewModel:
            self.classifyModel(digital_Coin_Model:digitalCoinDataArray))
        
        
    }
    
     func dataCanNotConvert(errorString: String) {
        
        self.delegate?.remindUserConnectionError(errorString: errorString)

    }
    
    func dataFetchFailed(errorString: String) {
        
        self.delegate?.remindUserConnectionError(errorString: errorString)

        
    }
    
    
    
    
}
