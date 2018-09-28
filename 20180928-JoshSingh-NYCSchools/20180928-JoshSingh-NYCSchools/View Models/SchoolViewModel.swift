//
//  SchoolViewModel.swift
//  20180928-JoshSingh-NYCSchools
//
//  Created by Yash Singh on 9/27/18.
//  Copyright © 2018 Yash Singh. All rights reserved.
//

import UIKit

class SchoolViewModel: NSObject {

    var schoolDataArray: [SchoolModel] = []    //stores the array of SchoolModel objects in View Model
    var satDataArray: Array<SATModel> = []          //stores the array of SATModel objects in View Model
    
    var searchedSchoolDataArray: [SchoolModel] = []   //stores results of the searched schools as an array of SchoolModel objects in View Model
    
    //converting strings to URL for use with URLSession
    let schoolURL = URL(string: UrlStrings.schoolURLString.rawValue)
    let satURL = URL(string: UrlStrings.satURLString.rawValue)
    
    /**
        This function uses the singleton shared instance of WebServiceAPIHandler to obtain the array of SchoolModel objects and assigns them to schoolDataArray. This schoolDataArray is then passed into the completion handler
     # IMPORTANT NOTES #
            1. parameter 1: completion: @escaping (Array<SchoolModel>) -> () - completion handler that passes in an array of SchoolModel objects.
     */
    func getSchoolData(completion: @escaping (Array<SchoolModel>)->()){
        
        WebServiceAPIHandler.sharedInstance.getData(urlAPI: schoolURL!) {[unowned self] (schoolData) in
            
            WebServiceAPIHandler.sharedInstance.getSchoolData(data: schoolData, completion: { [unowned self] (schoolArr) in
                self.schoolDataArray = schoolArr
                completion(self.schoolDataArray)
            })
        }
    }
    
    /**
     This function uses the singleton shared instance of WebServiceAPIHandler to obtain the array of SATModel objects and assigns them to satDataArray. This satDataArray is then passed into the completion handler
     # IMPORTANT NOTES #
            1. parameter 1: completion: @escaping (Array<SATModel>) -> () - completion handler that passes in an array of SATModel objects.
     */
    func getSATData(completion: @escaping (Array<SATModel>) -> ()){
        
        WebServiceAPIHandler.sharedInstance.getData(urlAPI: satURL!) {[unowned self] (satData) in
            
            WebServiceAPIHandler.sharedInstance.getSATData(data: satData, completion: { [unowned self] (satArr) in
                self.satDataArray = satArr
                completion(self.satDataArray)
            })
        }
        
    }
    
    func searchResults(searchText: String){
        searchedSchoolDataArray = schoolDataArray.filter({$0.school_name!.prefix(searchText.count) == searchText})
    }
}
