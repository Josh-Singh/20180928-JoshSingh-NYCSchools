//
//  SATModel.swift
//  20180928-JoshSingh-NYCSchools
//
//  Created by Yash Singh on 9/27/18.
//  Copyright © 2018 Yash Singh. All rights reserved.
//

import Foundation

//This model will store all the values obtained from the API response for SAT scores of a particular school

class SATModel: Decodable{
    
    var dbn: String?
    var num_of_sat_test_takers: String?
    var sat_critical_reading_avg_score: String?
    var sat_math_avg_score: String?
    var sat_writing_avg_score: String?
    var school_name: String?
    
}
