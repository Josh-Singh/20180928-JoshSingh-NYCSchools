//
//  SATViewController.swift
//  20180928-JoshSingh-NYCSchools
//
//  Created by Yash Singh on 9/27/18.
//  Copyright © 2018 Yash Singh. All rights reserved.
//

import UIKit

class SATViewController: UIViewController {

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var numOfTestTakersLabel: UILabel!
    @IBOutlet weak var criticalReadingScoreLabel: UILabel!
    @IBOutlet weak var mathsScoreLabel: UILabel!
    @IBOutlet weak var writingScoreLabel: UILabel!
    @IBOutlet weak var dbnLabel: UILabel!
    
    var viewModel: SATViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        // Do any additional setup after loading the view.
    }
    
    func setLabels(){
        DispatchQueue.main.async {
            self.schoolNameLabel.text = "Name: \(self.viewModel.satDataForSchool.school_name ?? "None")"
            self.numOfTestTakersLabel.text = "Number of Test Takers: \(self.viewModel.satDataForSchool.num_of_sat_test_takers ?? "0")"
            self.criticalReadingScoreLabel.text = "Critical Reading Average Score: \(self.viewModel.satDataForSchool.sat_critical_reading_avg_score ?? "0")"
            self.mathsScoreLabel.text = "Maths Average Score: \(self.viewModel.satDataForSchool.sat_math_avg_score ?? "0")"
            self.writingScoreLabel.text = "Writing Average Score: \(self.viewModel.satDataForSchool.sat_writing_avg_score ?? "0")"
            self.dbnLabel.text = "DBN: \(self.viewModel.satDataForSchool.dbn ?? "666")"
        }
    }
}
