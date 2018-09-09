//
//  DIgitalCoinViewModel.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import Foundation

protocol RefreshTableViewDelegate {
    
    func refreshTableView(digital_Coin_Model: [DigitalCoinModel])
    func remindUserConnectionError(errorString:String)
    
    }


class DigitalCoinViewModel:NetworkManagerDelegate{
  
    var delegate: RefreshTableViewDelegate?
    
    var digitalCoinDataArray:[DigitalCoinModel]=[]
    
     func requestData(){
    
        var networkingClient = NetworkingClient()
        networkingClient.delegate = self
        networkingClient.requestData()
    
    }
    
      func didReceiveData(digital_Coin_Model: [DigitalCoinModel]) {
        
        self.digitalCoinDataArray=digital_Coin_Model
        
        self.delegate?.refreshTableView(digital_Coin_Model: digital_Coin_Model)
       
        
            }

    
    func getDigitalCoinName(indexPath:IndexPath)->String{
        
        return digitalCoinDataArray[indexPath.row].baseAsset
        
    }
    
    func getDigitalCoinCompareName(indexPath:IndexPath)->String{
        
        return " / "+digitalCoinDataArray[indexPath.row].quoteAsset
    }
    
    func getDigitalCoinVolume(indexPath:IndexPath)->String{
        
        guard let volumeNumber = Double(digitalCoinDataArray[indexPath.row].volume) else {

            print(digitalCoinDataArray[indexPath.row].volume)

            return "Vol "+digitalCoinDataArray[indexPath.row].volume

        }
        
        
        return "Vol "+String(format:"%.0f",volumeNumber)
        
    }
    
    func getDigitalCoinRealPrice(indexPath:IndexPath)->String{
        
        return digitalCoinDataArray[indexPath.row].close
    }
    
    func getDigitalCoinComparePrice(indexPath:IndexPath)->String{
        
        return "$ "+digitalCoinDataArray[indexPath.row].close
        
    }
    
    func numberOfTableViewRows()->Int{
        
        return self.digitalCoinDataArray.count
        
    }
    
    
     func dataCanNotConvert(errorString: String) {
        
        self.delegate?.remindUserConnectionError(errorString: errorString)

    }
    
    func dataFetchFailed(errorString: String) {
        
        self.delegate?.remindUserConnectionError(errorString: errorString)

        
    }
    
    
    
    
}