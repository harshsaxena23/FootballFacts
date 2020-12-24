//
//  ViewController.swift
//  FootballFacts
//
//  Created by Harsh Saxena on 21/12/20.
//

import UIKit
import SDWebImageSVGCoder

class ViewController: UIViewController {
    
    @IBOutlet weak var standingsTableView:UITableView!
    @IBOutlet weak var dataContainerView: UIView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataLabel: UIView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var selectLeagueBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var leaguePickerView : UIPickerView!
    @IBOutlet weak var pickerContainerViewBottomLayoutConstraint: NSLayoutConstraint!
    
    var competitionsArray = [Competitions]()
    var standingsArray = [Standings]()
    let refreshControl = UIRefreshControl()
    
    var isPickerContainerVisible = false
    var selectedRow = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        leaguePickerView.delegate = self
        leaguePickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateContetForTableView()
    }
    
    func updateContetForTableView(){
        FootballFactsLoadView.showLoadingHUD(in: self.view)
        FootballFactsDataSource.fetchCompetitions { [weak self] _ in
            self?.fetchComeptitionsFromCoreData()
        } failure: { (message) in
            print(message)
        }
    }
    
    func fetchComeptitionsFromCoreData(){
        self.competitionsArray = CoreDataManager.sharedInstance.fetchComeptitionsFromCoreData()
        if competitionsArray.count == 0{
            self.standingsTableView.isHidden = true
            self.noDataView.isHidden = false
            FootballFactsLoadView.hideLoadingHUD(in: self.view)
        }else{
            self.noDataView.isHidden = true
            self.standingsTableView.isHidden = false
            self.leaguePickerView.reloadAllComponents()
            self.title = competitionsArray[selectedRow].name
            leaguePickerView.selectRow(selectedRow, inComponent: 0, animated: true)
            self.fetchLeagueStandingsFromServer(leagueId: Int(competitionsArray[selectedRow].id))
        }
    }
    
    func fetchLeagueStandingsFromServer(leagueId: Int){
        FootballFactsDataSource.fetchLeagueTitle(leagueID: leagueId) { [weak self] _ in
            FootballFactsLoadView.hideLoadingHUD(in: self?.view)
            self?.fetchLeagueStandingsFromCoreData(leagueId: leagueId)
        } failure: { _ in
            
        }
        
    }
    
    func fetchLeagueStandingsFromCoreData(leagueId: Int){
        self.standingsArray = CoreDataManager.sharedInstance.fetchStandingsFromCoreData(leagueId: Int16(leagueId))
        if self.standingsArray.count == 0{
            self.standingsTableView.isHidden = true
            self.noDataView.isHidden = false
        }else{
            self.standingsTableView.isHidden = false
            self.noDataView.isHidden = true
            self.standingsTableView.reloadData()
        }
        
        
    }
    
    @IBAction func tryAgainForData(_ sender: UIButton){
        self.competitionsArray.count > 0 ? self.fetchLeagueStandingsFromServer(leagueId: Int(competitionsArray[selectedRow].id)) : self.updateContetForTableView()
    }
    
    @IBAction func selectChoiceOfLeaguePressed(_ sender: UIBarButtonItem){
        
        if competitionsArray.count == 0{
            let alertConroller = FootballFactsLoadView.showAlertFor(title: "Error", message: "You don't have an active internet action", titleAction: "OK")
            present(alertConroller, animated: true, completion: nil)
        }else{
        if !isPickerContainerVisible{
            UIView.animate(withDuration: 0.5, animations: {
                self.pickerContainerViewBottomLayoutConstraint.constant = 0
                self.view.layoutIfNeeded()
                self.isPickerContainerVisible = true
            })
        }
        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem){
        self.dismissPicker()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem){
        FootballFactsLoadView.showLoadingHUD(in: self.view)
        self.title = competitionsArray[selectedRow].name
        self.fetchLeagueStandingsFromServer(leagueId: Int(competitionsArray[selectedRow].id))
        self.dismissPicker()
        
    }
    
    func dismissPicker(){
        UIView.animate(withDuration: 0.5, animations: {
            self.pickerContainerViewBottomLayoutConstraint.constant = -240
            self.isPickerContainerVisible = false
            self.view.layoutIfNeeded()
        })
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standingsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StandingsTableViewCell
        if standingsArray.count != 0{
            FootballFactsLoadView.loadCellForStandings(cell: cell, indexPath: indexPath, standings: standingsArray[indexPath.row])
        }else{
            if FootballFactsUtility.isNetworkReachable(){
                cell.textLabel?.text = ""
            }else{
                cell.textLabel?.text = "No data yet. Please connect to internet"
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPickerContainerVisible{
            dismissPicker()
        }
        let teamStandingsData = standingsArray[indexPath.row]
        FootballFactsLoadView.navigateToDetailScreen(navigationController: self.navigationController!, teamDetails: teamStandingsData)
    }
    
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return competitionsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return competitionsArray[row].name! + "(\(competitionsArray[row].code!))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    
}
