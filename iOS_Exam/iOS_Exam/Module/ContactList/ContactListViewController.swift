//
//  MainViewController.swift
//  iOS_Exam
//
//  Created by YeouTimothy on 2019/1/18.
//  Copyright © 2019 Timothy. All rights reserved.
//  MARK: 此 VC 使用 MVVM Pattern 撰寫
//  參考來源：https://www.codementor.io/koromiko/mvvm-app-cl1wvw2sh

import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingStatusLabel: UILabel!
    
    @IBAction func refreshAction(_ sender: Any) {
        ///強制刷新，會將所有資料源刪除
        viewModel.initFetch(true)
    }
    
    lazy var viewModel :ContactListViewModel = {
        return ContactListViewModel()
    }()
    
    typealias contactList = [ContactModel]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        initViewModel()
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "ContactListTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactListTableViewCell")
        tableView.separatorStyle = .none
    }
    
    ///針對 ViewModel 做初始化
    func initViewModel(){
        ///定義回調
        viewModel.updateLoadingStatus = {
            [weak self] () in
            DispatchQueue.main.async {
                self?.loadingStatusLabel.text = self?.viewModel.loadingStatus
            }
        }
        
        viewModel.reloadTableViewClosure = {
            [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        ///進行資料提取，不做資料初始化
        viewModel.initFetch(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? ContactDetailViewController{
            destinationController.selectedContact = viewModel.selectedContact
            destinationController.relatedContact = viewModel.relatedContact
        }
    }
    
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCell", for: indexPath) as! ContactListTableViewCell
        let cellModel = viewModel.getCellViewModel(at: indexPath)
        let name = cellModel.titleText + " " + cellModel.firstNameText + cellModel.lastnameText
        cell.nameLabel.text = name
        cell.phoneLabel.text = cellModel.phoneText
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userPressed(at: indexPath)
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
}
