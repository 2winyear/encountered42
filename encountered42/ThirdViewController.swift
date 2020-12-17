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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension ThirdViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.correctedInfo.count + self.correctorInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yeparkCell", for: indexPath) as! yeparkCell
        if (correctedInfo.count > indexPath.row) {
            let cellInfo = self.correctedInfo[indexPath.row]
            cell.firstLabel.text = "\(yourIntraId) : \(cellInfo.comment)"
            cell.secondLabel.text = "\(myIntraId) : \(cellInfo.feedback)"
        } else {
            let cellInfo = self.correctorInfo[indexPath.row - correctedInfo.count]
            cell.secondLabel.text = "\(yourIntraId) : \(cellInfo.comment)"
            cell.firstLabel.text = "\(myIntraId) : \(cellInfo.feedback)"
        }

        return cell
    }
    
    
}
