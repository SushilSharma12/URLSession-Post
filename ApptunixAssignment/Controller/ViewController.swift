//
//  ViewController.swift
//  ApptunixAssignment
//
//  Created by SUSHIL SHARMA on 24/07/20.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var tableRows = 0
    var restData: RestData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = 250
        self.showRestaurantList()
    }
    
    // MARK: Populating data in table
    func showRestaurantList(){
        self.getRestList { [weak self] (list) -> (Void) in
            DispatchQueue.main.async {
                self?.loaderView.isHidden = true
                self?.tableRows = list?.data?.getSections() ?? 0
                self?.tableView.reloadData()
                self?.restData = list?.data
                UserDefaults.standard.set(true, forKey: "hasLaunched")
            }
        }
    }

    //MARK: - API Call
    func getRestList(completion: @escaping (_ list: RestModel?) -> ()){
        HTTPHandler.shared.postRequest(with: URL(string: API.baseUrl + EndPoints.getRestList)!, params: ["latitude": 30.3241, "longitude": 76.67234]) { (response, error) in

            guard let resp = response else {
                completion(nil)
                return
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: resp, options: .fragmentsAllowed)
                let restModel = try JSONDecoder().decode(RestModel.self, from: jsonData)
                
                completion(restModel)
                
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? RestBaseTableCell
        cell?.collectionView.tag = indexPath.row
        if tableRows > indexPath.row{
            if indexPath.row == 0{
                cell?.categories = self.restData?.categories
            } else if indexPath.row == 1{
                cell?.saved = self.restData?.saved
            } else if indexPath.row == 2{
                cell?.bestOffer = self.restData?.bestOffers
            } else if indexPath.row == 3{
                cell?.recommended = self.restData?.recommended
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return 270
        }
    }
    
}
