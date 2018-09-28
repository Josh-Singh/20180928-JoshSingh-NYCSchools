//
//  SchoolListViewController.swift
//  20180928-JoshSingh-NYCSchools
//
//  Created by Yash Singh on 9/27/18.
//  Copyright © 2018 Yash Singh. All rights reserved.
//

import UIKit

class SchoolListViewController: UIViewController {

    @IBOutlet weak var schoolTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let schoolVM = SchoolViewModel()
    var searchFlag: Bool = false       //to indicate if we are currently searching a school
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolTableView.estimatedRowHeight = 100
        schoolTableView.tableFooterView = UIView(frame: .zero)
        //eliminates extraneous rows from the table view
        
        setupTableViewDataSource()
        getSATDataForAllSchools()
        setupRefreshControl()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupTableViewDataSource), name: UIApplication.willTerminateNotification, object: nil)
    }
    /**
     This function will receive the array of SchoolModel objects from the corresponding singleton class function and store it in schoolsArray and reload the table view in the main queue
     */
    @objc func setupTableViewDataSource() {
        
//        schoolVM.schoolDataArray.removeAll()
        schoolVM.getSchoolData { [unowned self] (obtainedSchoolArr) in

            //if no schools to show then display alert view with error
            if obtainedSchoolArr.count == 0{
                self.alertView(message: "No Schools to Show")
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                //reload the table view
                self.schoolTableView.reloadData()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SchoolListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func setupRefreshControl() {
        
        refreshControl.isEnabled = true
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(setupTableViewDataSource), for: .valueChanged)
        //refreshAction method down below
        schoolTableView.addSubview(refreshControl)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        schoolVM.searchResults(searchText: searchText)
        searchFlag = true
        schoolTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchFlag = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        schoolTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searchFlag == true{
            return schoolVM.searchedSchoolDataArray.count
        }
        else{
            return schoolVM.schoolDataArray.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.schoolCell)
        if searchFlag == true{
            cell?.textLabel?.text = schoolVM.searchedSchoolDataArray[indexPath.row].school_name
            cell?.detailTextLabel?.text = schoolVM.searchedSchoolDataArray[indexPath.row].borough
        }else{
        cell?.textLabel?.text = schoolVM.schoolDataArray[indexPath.row].school_name
            cell?.detailTextLabel?.text = schoolVM.schoolDataArray[indexPath.row].borough
        }
        return cell!
    }
    
    /**
        This function will receive the array for all the schools' SAT stats from the corresponding singleton class function and store it in satArray
     */
    func getSATDataForAllSchools(){
        schoolVM.getSATData {(obtainedSATArr) in
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //iterate through all the SATModel objects in satArray using for..in and check which school has been selected using the dbn variable in both SATModel and SchoolModel.
        var selectedArray: Array<SchoolModel> = []
        
        if searchFlag == true{
            selectedArray = schoolVM.searchedSchoolDataArray
        }else{
            selectedArray = schoolVM.schoolDataArray
        }

        if let controller = storyboard?.instantiateViewController(withIdentifier: ViewControllerNames.satViewController) as? SATViewController{
            
            //pass the SATModel corresponding to the selected row to SATViewController using delegate variable satDataForSchool if school is
            let filteredObj = schoolVM.satDataArray.filter {$0.dbn == selectedArray[indexPath.row].dbn}
            if filteredObj.count > 0 {
                
                let satModel = SATViewModel(model: filteredObj.first!)
                controller.viewModel = satModel
                navigationController?.pushViewController(controller, animated: true)
            } else {
                self.alertView(message: "School Not Found")
            }
        }
    }
}
