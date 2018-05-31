//
//  ViewController.swift
//  weather api
//
//  Created by Ayush Verma on 13/03/18.
//  Copyright © 2018 Ayush Verma. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    var url = "https://api.openweathermap.org/data/2.5/forecast?id="
    var cityId = "524901"
    let apiKey = "2ca95193405ac2cab082bd4009dbdf9f"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let FINALURL = url+cityId+"&APPID="+apiKey
        
        
        guard let finalUrl = URL(string: FINALURL) else {
            return
        }
        
        Alamofire.request(finalUrl, method: .get)
        
            .responseJSON { (response) in
                print(response)
                
                
                
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    


}

