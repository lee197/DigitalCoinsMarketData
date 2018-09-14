//
//  DigitalCoinTableViewModel.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 13/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import Foundation




 class DigitalCoinTableViewModel:NSObject{
    
    var digitalCoinDataArray:[DigitalCoinModel]=[]
    weak var delegate: NetworkingResultDelegate?

    /**
     
     initialise the instance with Models
     
     - parameter: [DigitalCoinModel] the models for initialisation
     
     - returns: Void
     
     */
    
    init(digitalCoinDataArray: [DigitalCoinModel]) {
        
        self.digitalCoinDataArray=digitalCoinDataArray
    }
    
    
    /**
     
     set the relevant features for tableView Cell
     
     - parameter: the indexPath of tableView Cell

     - returns: the name of the coin
     
     */
    
    func getDigitalCoinName(indexPath:IndexPath)->String{
        
        return digitalCoinDataArray[indexPath.row].baseAsset
        
    }
    
    /**
     
     set the relevant features for tableView Cell
     
     - parameter: the indexPath of tableView Cell
     
     - returns: the comparation coin name
     
     */
    
    func getDigitalCoinCompareName(indexPath:IndexPath)->String{
        
        return " / "+digitalCoinDataArray[indexPath.row].quoteAsset
    }
    
    /**
     
     set the relevant features for tableView Cell
     
     - parameter: the indexPath of tableView Cell
     
     - returns: the volum of the coin
     
     */
    
    func getDigitalCoinVolume(indexPath:IndexPath)->String{
        
        guard let volumeNumber = Double(digitalCoinDataArray[indexPath.row].volume) else {
            
            
            return "Vol "+digitalCoinDataArray[indexPath.row].volume
            
        }
        
        return "Vol "+String(format:"%.0f",volumeNumber)
        
    }
    
    
    /**
     
     set the relevant features for tableView Cell
     
     - parameter: the indexPath of tableView Cell
     
     - returns: the price of the coin
     
     */
    func getDigitalCoinRealPrice(indexPath:IndexPath)->String{
        
        return digitalCoinDataArray[indexPath.row].close
    }
    
    
    /**
     
     set the relevant features for tableView Cell
     
     - parameter: the indexPath of tableView Cell
     
     - returns: the comparation price of the coin
     
     */
    func getDigitalCoinComparePrice(indexPath:IndexPath)->String{
        
        return "$ "+digitalCoinDataArray[indexPath.row].close
        
    }
    
    
    /**
     
     return the number of table view rows
     - parameter: the indexPath of tableView Cell
     
     - returns: the number of the rows
     
     */
    func numberOfTableViewRows()->Int{
        
        return self.digitalCoinDataArray.count
        
    }
    
    
}


extension DigitalCoinTableViewModel:NetworkManagerDelegate{

    /**
     
     request the data for refresh
     - parameter: void
     
     - returns: void
     
     */

    func requestRefreshNetworkingData(){
        
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
        
        
        let digitalCoinViewModel=DigitalCoinViewModel()

        self.delegate?.sendSuccessResult(digital_Coin_TableViewModel:digitalCoinViewModel.classifyModel(digital_Coin_Model: digital_Coin_Model))
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
