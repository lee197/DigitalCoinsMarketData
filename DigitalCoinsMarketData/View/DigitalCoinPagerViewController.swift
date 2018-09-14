//
//  DigitalCoinPriceTableViewController.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 13/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import XLPagerTabStrip
import UIKit
import Foundation


class DigitalCoinPagerViewController:ButtonBarPagerTabStripViewController,NetworkingResultDelegate{
    
    var digitalCoinViewModel=DigitalCoinViewModel()
    var itemInfoArray = Array<DigitalCoinTableViewModel>()
    var searchBar: UISearchBar = UISearchBar()

    var searchBarButtonsItemRight: UIBarButtonItem?

    override func viewDidLoad() {
        
        super.viewDidLoad()

        requestNetworkingData()
        
        setUpButtonView()
        
        searchBarButtonsItemRight = navigationItem.rightBarButtonItem

    }
    
    
    func setUpButtonView(){
        
        buttonBarView.delegate = self
        buttonBarView.dataSource = self
        
        buttonBarView.selectedBar.backgroundColor = .orange
        buttonBarView.backgroundColor = .black
        settings.style.buttonBarItemTitleColor = .white
        
        settings.style.buttonBarItemBackgroundColor = .black
        
        buttonBarView.moveTo(index: 0, animated: true, swipeDirection: .none, pagerScroll: .no)
        buttonBarView.accessibilityPerformMagicTap()
        
    }
    
    func requestNetworkingData(){
        
        digitalCoinViewModel.delegate = self
        digitalCoinViewModel.requestNetworkingData()
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var itemViewControllerArray = Array<DigitalCoinTableViewController>()

        let itemViewController0 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigitalCoinTableViewController") as! DigitalCoinTableViewController

        let itemViewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigitalCoinTableViewController") as! DigitalCoinTableViewController
        
        let itemViewController2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigitalCoinTableViewController") as! DigitalCoinTableViewController
        
        let itemViewController3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigitalCoinTableViewController") as! DigitalCoinTableViewController


        if itemInfoArray.count != 0 {
            
            itemViewController0.setData(digitalCoinTableViewModel:self.itemInfoArray[0])
            itemViewController1.setData(digitalCoinTableViewModel:self.itemInfoArray[1])
            itemViewController2.setData(digitalCoinTableViewModel:self.itemInfoArray[2])
            itemViewController3.setData(digitalCoinTableViewModel:self.itemInfoArray[3])

            
        }
        

        itemViewControllerArray.append(itemViewController0)
        itemViewControllerArray.append(itemViewController1)
        itemViewControllerArray.append(itemViewController2)
        itemViewControllerArray.append(itemViewController3)

        return itemViewControllerArray
        
    }
    
    func sendSuccessResult(digital_Coin_TableViewModel: [DigitalCoinTableViewModel]) {
        
        if digital_Coin_TableViewModel.count != 0 {
            
        self.itemInfoArray=digital_Coin_TableViewModel
            print(itemInfoArray[0].digitalCoinDataArray.count)
        self.reloadPagerTabStripView()
            
        }
    }
    

  
    
    func remindUserConnectionError(errorString: String) {
        
    }
    
    
}

extension DigitalCoinPagerViewController:UISearchBarDelegate{
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.showsCancelButton = true
        
        
        navigationItem.titleView = searchBar
        searchBar.alpha = 0
        navigationItem.setRightBarButton(nil, animated: true)
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
        
    }
    
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        digitalCoinViewModel.cancelSearch()
        
        
        self.searchBar.isHidden=true
        
        let titleLabel:UILabel = UILabel()
        titleLabel.text = "Markets"
        

        UIView.animate(withDuration: 0.5, animations: {
            
            self.navigationItem.titleView=titleLabel
            self.navigationItem.setRightBarButton(self.searchBarButtonsItemRight, animated: true)

        }, completion: { finished in
            
            
            self.searchBar.resignFirstResponder()
            
        })
        
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchWords = searchBar.text else {
            
            return
        }
        
        
        digitalCoinViewModel.searchByKeywords(searchWords: searchWords.uppercased(), completion: { digital_Coin_TableViewModel in
    
            self.itemInfoArray=digital_Coin_TableViewModel!

            
            if self.itemInfoArray[0].digitalCoinDataArray.count == 0 && self.itemInfoArray[1].digitalCoinDataArray.count == 0 && self.itemInfoArray[2].digitalCoinDataArray.count == 0 && self.itemInfoArray[3].digitalCoinDataArray.count == 0{
                
                let alert = UIAlertController(title: "Alert", message: "Sorry, there is no results", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action:UIAlertAction) in
                    
                    self.digitalCoinViewModel.cancelSearch()

                })
            
                
                self.present(alert, animated: true, completion: nil)

                
            }
            
                self.reloadPagerTabStripView()
        
})
    }
}

