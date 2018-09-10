//
//  ViewController.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 07/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NetworkingResultDelegate{
  
    @IBOutlet weak var tableView: UITableView!
    var digitalCoinViewModel = DigitalCoinViewModel()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.allowsSelection = false
        fetchData()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    }

    @objc func fetchData(){
        
        digitalCoinViewModel.delegate = self
        digitalCoinViewModel.requestNetworkingData()
        
    }

    
    func sendSuccessResult(isSuccess: Bool) {
        
        if isSuccess {
            
            self.refreshControl.endRefreshing()

            self.tableView.reloadData()

        }

    }
    
    func remindUserConnectionError(errorString: String) {
        
        
        
        let alert = UIAlertController(title: "Alert", message: errorString, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default){ (action:UIAlertAction) in
            
            self.fetchData()

        })

        self.present(alert, animated: true, completion: nil)
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return digitalCoinViewModel.numberOfTableViewRows()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DigitalCoinTableViewCell
        
        cell.assetNameLabel.text = digitalCoinViewModel.getDigitalCoinName(indexPath: indexPath)
        cell.assetCompareNameLabel.text = digitalCoinViewModel.getDigitalCoinCompareName(indexPath: indexPath)
        cell.volumLabel.text = digitalCoinViewModel.getDigitalCoinVolume(indexPath: indexPath)
        cell.realPriceLabel.text = digitalCoinViewModel.getDigitalCoinRealPrice(indexPath: indexPath)
        cell.assetComparePriceLabel.text = digitalCoinViewModel.getDigitalCoinComparePrice(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
