//
//  ViewController.swift
//  encountered42
//
//  Created by 박영광 on 2020/12/16.
//  Copyright © 2020 박영광. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var meTextField: UITextField!
    @IBOutlet weak var youTextField: UITextField!
    
    var token = String()
    let url = URL(string: "https://api.intra.42.fr")
    let apitokenUrl = URL(string: "https://api.intra.42.fr/oauth/token")
    let uid: String = "84fd4a46fe9e39113c061173276dd4dbfd1d17ed1c75c8c20fb22ea3ce5096d7"
    let secret: String = "800ce2c38c654f84b4271d59f884cbb306c9586d00654dac2f7eb9466a71bda6"
    let userLink: String = "/v2/users/"
    let redirectUri = "naver.com"
    
    var myID = String()
    var yourID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        while (token == "") {
            print(token)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? SecondViewController else {
            return
        }
        nextViewController.myIntraId = meTextField.text!
        nextViewController.yourIntraId = youTextField.text!
        nextViewController.secondToken = self.token
    }
    
    @IBAction func touchUpButton(_ sender: Any) {

    }
   
    func getToken() {
        let parameters = [
            "grant_type": "client_credentials",
            "client_id": self.uid,
            "client_secret": self.secret]

        let paramData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
      
        var request = URLRequest(url: self.apitokenUrl!)
        request.httpMethod = "POST"
        request.httpBody = paramData

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")

        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            
//            let responseString = String(data: data, encoding: .utf8)
            if let accessToken = json!["access_token"] {
                self.token = accessToken as! String
                sleep(3)
            }
        }
        task.resume()
    }
}

