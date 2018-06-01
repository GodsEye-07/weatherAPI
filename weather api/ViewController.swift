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
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var LongitudeLabel: UILabel!
    @IBOutlet weak var currentImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    let url = "https://api.openweathermap.org/data/2.5/forecast?id="
    var cityId = "524901"
    let apiKey = "2ca95193405ac2cab082bd4009dbdf9f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherData()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func weatherData(){
        
        guard let finalUrl = URL(string: "\(url)\(cityId)&APPID=\(apiKey)") else {
            return
        }
        
        print(finalUrl)
        
        Alamofire.request(finalUrl, method: .get)

            .responseJSON { (response) in
  
                if let res = response.value as? Dictionary<String,AnyObject>{
                    if let city = res["city"] as? Dictionary<String,Any>{
                        if let cityName = city["name"] as? String{
                            self.cityNameLabel.text = cityName
                            print(cityName)
                        }
                        if let countryName = city["country"] as? String{
                            print(countryName)
                            if countryName == "RU"{
                                self.countryNameLabel.text = "Russia"
                            }

                        }
                        if let coord = city["coord"] as? Dictionary<String,AnyObject>{
                            if let latitude  = coord["lat"] as? Float{
                                self.latitudeLabel.text = "\(latitude)"
                                print(latitude)
                            }
                            if let longitude  = coord["lon"] as? Float {
                                self.LongitudeLabel.text = String(longitude)
                                print(longitude)
                            }
                        }
                        if let cityId = city["id"] as? Int{
                            print(cityId)
                        }
                    }
                    if let list = res["list"] as? [Dictionary<String,AnyObject>]{
                        for i in 0..<list.count{
                            if let dateText = list[i]["dt_txt"] as? String{
//                                print(dateText)
                            }
                            if let weatherDetail = list[i]["weather"] as? [Dictionary<String,AnyObject>]{
                                if let weather = weatherDetail[0]["main"] as? String{
//                                    print(weather)
                                }
                            }
                            if let mainData = list[i]["main"] as? Dictionary<String,Double>{
                                if let temprature = mainData["temp"] {
//                                    print(temprature)
                                }
                                if let max_temp = mainData["temp_max"]{
//                                    print(max_temp)
                                }
                                if let min_temp = mainData["temp_min"]{
//                                    print(min_temp)
                                }
                                if let pressure = mainData["pressure"]{
//                                    print(pressure)
                                }
                                if let humidity = mainData["humidity"]{
//                                    print(humidity)
                                }
                            }
                        }
                    }
                }
            }
        }
    
    
    


}
