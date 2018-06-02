//
//  ViewController.swift
//  weather api
//
//  Created by Ayush Verma on 13/03/18.
//  Copyright © 2018 Ayush Verma. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var LongitudeLabel: UILabel!
    @IBOutlet weak var currentImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let url = "https://api.openweathermap.org/data/2.5/forecast?id="
    var cityId = "524901"
    let apiKey = "2ca95193405ac2cab082bd4009dbdf9f"
    
    var currentTemprature = [String]()
    var lowestTemp = [String]()
    var maxTemp = [String]()
    var pressure = [String]()
    var humidity = [String]()
    var currentWeather = [String]()
    var dateAndTime = [String]()
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
//        print(finalUrl)
        
        Alamofire.request(finalUrl, method: .get)

            .responseJSON { (response) in
  
                if let res = response.value as? Dictionary<String,AnyObject>{
                    if let city = res["city"] as? [String:Any]{
                        if let cityName = city["name"] as? String{
                            self.cityNameLabel.text = cityName
//                            print(cityName)
                        }
                        if let countryName = city["country"] as? String{
//                            print(countryName)
                            if countryName == "RU"{
                                self.countryNameLabel.text = "Russia"
                            }

                        }
                        if let coordinate = city["coord"] as? [String:Any]{
                            if let latitude = coordinate["lat"] as? Double{
                                self.latitudeLabel.text = "\(latitude)"
//                                print(latitude)
                            }
                            if let longitude = coordinate["lon"] as? Double{
                                self.LongitudeLabel.text = String(longitude)
//                                    print(longitude)
                            }
                        }
                    }
                    if let list = res["list"] as? [Dictionary<String,AnyObject>]{
                        for i in 0..<list.count{
                            if let dateText = list[i]["dt_txt"] as? String{
                                self.dateAndTime.append(dateText)
                            }
                            if let weatherDetail = list[i]["weather"] as? [Dictionary<String,AnyObject>]{
                                if let weather = weatherDetail[0]["main"] as? String{
                                    self.currentWeather.append(weather)
                                }
                            }
                            if let mainData = list[i]["main"] as? Dictionary<String,Double>{
                                if let temprature = mainData["temp"] {
                                    self.currentTemprature.append(String(temprature))
                                }
                                if let max_temp = mainData["temp_max"]{
                                    self.maxTemp.append(String(max_temp))
                                }
                                if let min_temp = mainData["temp_min"]{
                                    self.lowestTemp.append(String(min_temp))
                                }
                                if let pressure = mainData["pressure"]{
                                    self.pressure.append(String(pressure))
                                }
                                if let humidity = mainData["humidity"]{
                                    self.humidity.append(String(humidity))
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }.resume()
        }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTemprature.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! weatherTableViewCell
        
        cell.currentTempLabel.text = currentTemprature[indexPath.row]
        cell.minimumTempLabel.text = lowestTemp[indexPath.row]
        cell.maxTempLabel.text = maxTemp[indexPath.row]
        cell.pressureLabel.text = pressure[indexPath.row]
        cell.humidityLabel.text = humidity[indexPath.row]
        cell.dateTimeLabel.text = dateAndTime[indexPath.row]
        cell.weatherImageView.image = UIImage(named: "\(currentWeather) Mini")
        
        
        if currentTemprature.count == 0{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
        else{
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    

}
