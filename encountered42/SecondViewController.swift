//
//  SecondViewController.swift
//  encountered42
//
//  Created by 박영광 on 2020/12/17.
//  Copyright © 2020 박영광. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var myIntraId :String = ""
    var yourIntraId :String = ""
    
    var secondToken :String = ""
    var correctedInfo = [Welcome]()
    var correctorInfo = [Welcome]()
    var correctedNum = 0
    var correctorNum = 0
    
    @IBOutlet weak var firstPushButton: UIButton!
    @IBOutlet weak var secondPushButton: UIButton!
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ThirdViewController else {
            return
        }
        nextViewController.myIntraId = self.myIntraId
        

        nextViewController.correctedInfo = self.correctedInfo
        nextViewController.correctorInfo = self.correctorInfo
        nextViewController.yourIntraId = self.yourIntraId
    }
    
    
    @IBAction func testTouch(_ sender: Any) {
        print("먼데")
        print(myIntraId)
        print(yourIntraId)
        print("먼데2")
        corretedMe()
        print("위에가 평가 받은거 밑에서 평가 한거 ")
        corretorYou()
        self.firstPushButton.isHidden = true
        self.secondPushButton.isHidden = false
    }
    
    
    //https://api.intra.42.fr/v2/users/72449/scale_teams/as_corrected
    //https://api.intra.42.fr/v2/users/72449/scale_teams/as_corrector
    //https://api.intra.42.fr/v2/users/72449/scale_teams/as_corrected?page[number]=3
    
    
    func corretedMe(){
        var count = 0
        var ryukim = 1
        repeat {
            var tempCount = 0
            let url = "https://api.intra.42.fr/v2/users/\(myIntraId)/scale_teams/as_corrected?page[number]=\(ryukim)"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer \(self.secondToken)"
            ]
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print("error")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but iws \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
//                print(json)
                
                let hello = try? JSONDecoder().decode([Welcome].self, from: data)
                hello?.forEach { (jaejeon) in
                    if (jaejeon.corrector.login == self.yourIntraId) {
                        self.correctedInfo.append(jaejeon)
                        print(jaejeon.corrector.login)
                    }
                    tempCount += 1
                }
                count = tempCount
                self.correctedNum += count
                print(count)
            }
            task.resume()
            sleep(4)
            ryukim = ryukim + 1
        }while (count != 0)
    }
    
    func corretorYou(){
        var count = 0
        var ryukim = 1
        repeat {
            var tempCount = 0
            let url = "https://api.intra.42.fr/v2/users/\(myIntraId)/scale_teams/as_corrector?page[number]=\(ryukim)"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer \(self.secondToken)"
            ]
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print("error")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but iws \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                
                let hello = try? JSONDecoder().decode([Welcome].self, from: data)
                hello?.forEach { (jaejeon) in
                    if jaejeon.correcteds[0].login == self.yourIntraId {
                        self.correctorInfo.append(jaejeon)
                        print(jaejeon.correcteds[0].login)
                    }
                    tempCount += 1
                }
                count = tempCount
                print(count)
            }
            task.resume()
            sleep(4)
            ryukim = ryukim + 1
        }while (count != 0)
    }
}
