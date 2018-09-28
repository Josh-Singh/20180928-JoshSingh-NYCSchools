//
//  WebServiceAPIHandler.swift
//  20180928-JoshSingh-NYCSchools
//
//  Created by Yash Singh on 9/27/18.
//  Copyright © 2018 Yash Singh. All rights reserved.
//

import UIKit
import Foundation
/**
 This is an enum for storing all the URLs required for API calls in string format
 */
enum UrlStrings: String{
    ///- URL for all schools; 1st screen
        case schoolURLString = "https://data.cityofnewyork.us/resource/97mf-9njv.json"

    ///- URL for SAT scores of all schools; 2nd screen
        case satURLString = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
}

class WebServiceAPIHandler: NSObject {
    //Singleton setup for this class
    private override init() {}
    static let sharedInstance = WebServiceAPIHandler()
    
    
//    var schoolDataArray: Array<SchoolModel> = []    //array that will store data from all the schools obtained via API call to schoolURL
    
    /**
        This function takes in a URL and obtains data doing an API call using URLSession
        # Important Notes #
            1. parameter 1: urlAPI - URL passed in for making the API call
            2. parameter 2: completion: @escaping(Data?) -> () - completion handler that gives the data obtained from the API call
     */
    func getData(urlAPI: URL, completion: @escaping (Data?) -> ()){
        
        URLSession.shared.dataTask(with: urlAPI) { (data, response, error) in
            if error != nil{
                print("Error occurred while obtianing response from schoolURL\n")
                completion(nil)
            }else{
                //Data has been successfully obtained, hence pass it in the completion handler
                completion(data!)
                
            }
            
        }.resume()
        
        
    }
    /**
        This function will receive the data from the API for schools in New York and store it in an array of SchoolModel. It will return this array in the completion handler.
     
        # Important Notes #
            1. parameter 1 => data - takes in data obtained from an API call, such as URLSession.datatask
            2. parameter 2 => completion: @escaping(Array<SchoolModel>) -> () - passes an array of SchoolModel objects inside the completion handler
            3. JSON object obtained from data is an array of dictionaries
     */
    func getSchoolData(data: Data?, completion: @escaping(Array<SchoolModel>) -> ()){
        if let usableSchoolData = data{
            do{
                if let jsonObject = try JSONSerialization.jsonObject(with: usableSchoolData, options: .mutableContainers) as? Array<Dictionary<String, Any>>
                {
                    print("School JSON object obtained has: \(jsonObject.count) members")
                    
                    //iterating through the array of dictionaries obtained from the API call using for..in
                    var schoolDataArray = [SchoolModel]()
                    for schoolDict in jsonObject{
                        var schoolData = SchoolModel()    //model object to store relevant details of school
                        
                        schoolData.school_name = schoolDict["school_name"] as? String ?? "Unavailable school"
                        schoolData.borough = schoolDict["borough"] as? String ?? "No state"
                        schoolData.dbn = schoolDict["dbn"] as? String ?? "666"
                        
                        schoolDataArray.append(schoolData)    //adding the SchoolModel object to the array. This array will be finally displayed in the table view
                        
                    }
                    print("Array for the schools has: \(schoolDataArray.count) schools\n")
                    completion(schoolDataArray)
                }
                
            }catch{
                print("Caught an error in obtaining JSONSerialised data")
            }
        }
        
    }
    
    
    /**
        This function will receive the data from the API for SAT stats for schools in New York and store it in an array of SATModel. It will return this array in the completion handler.
     
        # Important Notes #
            1. parameter 1 => data - takes in data obtained from an API call, such as URLSession.datatask
            2. parameter 2 => completion: @escaping(Array<SATModel>) -> () - passes an array of SATModel objects inside the completion handler
            3. JSON object obtained from data is an array of dictionaries
     */
    
    func getSATData(data: Data?, completion: @escaping(Array<SATModel>) -> ()){
        if let usableSATData = data{
            do{
                let satModelInfoArray = try JSONDecoder().decode(Array<SATModel>.self, from: usableSATData)
                print("Number of schools with valid SAT stats are: \(satModelInfoArray.count)\n")
                completion(satModelInfoArray)
                
            }catch{
                print("Problem with obtaining data from JSONDecoder")
                completion([])
            }
        }
        
    }
    
}
