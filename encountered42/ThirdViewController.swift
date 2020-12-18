//
//  ThirdViewController.swift
//  encountered42
//
//  Created by 박영광 on 2020/12/18.
//  Copyright © 2020 박영광. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    var correctedInfo :[Welcome] = []
    var correctorInfo :[Welcome] = []
    var myIntraId :String = ""
    var yourIntraId :String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var feedbackTableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if correctedInfo.count + correctorInfo.count == 0 {
            feedbackTableVIew.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ThirdViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.correctedInfo.count == 0 ? 1 : correctedInfo.count
        } else if section == 1 {
            return self.correctorInfo.count == 0 ? 1 : correctorInfo.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yeparkCell", for: indexPath) as! yeparkCell
        
        if (indexPath.section == 0) {
            if self.correctedInfo.count == 0 {
                cell.firstLabel.text = "\(myIntraId)은 \(yourIntraId)에게 평가 받은 것이 없군요"
                cell.secondLabel.text = ""
            } else {
                let cellInfo = self.correctedInfo[indexPath.row]
                cell.firstLabel.text = "\(yourIntraId) : \(cellInfo.comment ?? "")"
                cell.secondLabel.text = "\(myIntraId) : \(cellInfo.feedback ?? "")"
            }
        } else {
            if self.correctorInfo.count == 0 {
                cell.firstLabel.text = "\(myIntraId)은 \(yourIntraId)에게 평가 한 것이 없군요"
                cell.secondLabel.text = ""
            } else {
                let cellInfo = self.correctorInfo[indexPath.row]
                cell.secondLabel.text = "\(yourIntraId) : \(cellInfo.comment ?? "")"
                cell.firstLabel.text = "\(myIntraId) : \(cellInfo.feedback ?? "")"
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "\(myIntraId)가 \(yourIntraId)에게 평가 받은 것"
        } else {
            return "\(myIntraId)가 \(yourIntraId)에게 평가 한 것"
        }
    }
    
    
}
