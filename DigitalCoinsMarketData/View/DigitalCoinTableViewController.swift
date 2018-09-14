//
//  ViewController.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DigitalCoinTableViewController: UIViewController,NetworkingResultDelegate{
   
  
    @IBOutlet weak var tableView: UITableView!
    var digitalCoinTableViewModel=DigitalCoinTableViewModel(digitalCoinDataArray: [])
    private let refreshControl = UIRefreshControl()

    
    func setData(digitalCoinTableViewModel:DigitalCoinTableViewModel) {

        self.digitalCoinTableViewModel=digitalCoinTableViewModel

    }

  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.allowsSelection = false
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchRefreshData), for: .valueChanged)

    }

    @objc func fetchRefreshData(){
        
        digitalCoinTableViewModel.delegate = self
        digitalCoinTableViewModel.requestRefreshNetworkingData()
        
    }

    func sendSuccessResult(digital_Coin_TableViewModel: [DigitalCoinTableViewModel]) {
        
        if digital_Coin_TableViewModel.count != 0 {
            
            for itemTableViewModel in digital_Coin_TableViewModel{

//                print(itemTableViewModel.digitalCoinDataArray[0].quoteAsset)
//                print(self.digitalCoinTableViewModel.digitalCoinDataArray[0].quoteAsset)

                    if itemTableViewModel.digitalCoinDataArray[0].quoteAsset == self.digitalCoinTableViewModel.digitalCoinDataArray[0].quoteAsset{
                        
                        self.digitalCoinTableViewModel=itemTableViewModel
                        
                    }
            }
            
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
        
    }
    
    
    func remindUserConnectionError(errorString: String) {
        
        
        let alert = UIAlertController(title: "Alert", message: errorString, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default){ (action:UIAlertAction) in
            
            self.fetchRefreshData()

        })

        self.present(alert, animated: true, completion: nil)
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



extension DigitalCoinTableViewController:UITableViewDelegate,UITableViewDataSource,IndicatorInfoProvider {
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
         if digitalCoinTableViewModel.digitalCoinDataArray.count != 0 {
            
            let titleString = digitalCoinTableViewModel.digitalCoinDataArray[0].quoteAsset
            
            return IndicatorInfo(title: titleString)

        }
        return IndicatorInfo(title: "BNB")


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return digitalCoinTableViewModel.numberOfTableViewRows()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DigitalCoinTableViewCell

        cell.assetNameLabel.text = digitalCoinTableViewModel.getDigitalCoinName(indexPath: indexPath)
        cell.assetCompareNameLabel.text = digitalCoinTableViewModel.getDigitalCoinCompareName(indexPath: indexPath)
        cell.volumLabel.text = digitalCoinTableViewModel.getDigitalCoinVolume(indexPath: indexPath)
        cell.realPriceLabel.text = digitalCoinTableViewModel.getDigitalCoinRealPrice(indexPath: indexPath)
        cell.assetComparePriceLabel.text = digitalCoinTableViewModel.getDigitalCoinComparePrice(indexPath: indexPath)

        return cell
    }
    

    

  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
