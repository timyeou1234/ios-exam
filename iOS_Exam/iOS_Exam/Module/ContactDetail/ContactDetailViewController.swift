//
//  ContactDetailViewController.swift
//  iOS_Exam
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//  MARK: 此 VC 未使用 MVVM Pattern 撰寫，主要考量此處尚無任何交互，避免降低易讀性


import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedContact :ContactModel?
    var relatedContact  :ContactModel?
    
    let titleList = ["First name", "Last name", "Birthday", "Age", "Email address", "Mobile number", "Address", "Contact person", "Contact person's phone number"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ContactDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactDetailTableViewCell")
    }
    
}

extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailTableViewCell", for: indexPath) as! ContactDetailTableViewCell
        cell.selectionStyle = .none
        cell.titleLabel.text = titleList[indexPath.row]
        
        var descText = ""
        switch indexPath.row {
        case 0:
            descText = selectedContact?.name.first ?? " "
            break
        case 1:
            descText = selectedContact?.name.last ?? " "
            break
        case 2:
            if let date = selectedContact?.dob.date{
                if (date.count > 9){
                    descText = String(date.prefix(9))
                }else{
                    descText = " "
                }
            }else{
                descText = " "
            }
            break
        case 3:
            if let age = selectedContact?.dob.age{
                descText = "\(age)"
            }else{
                descText = " "
            }
            break
        case 4:
            descText = selectedContact?.email ?? " "
            break
        case 5:
            descText = selectedContact?.cell ?? " "
            break
        case 6:
            if let location = selectedContact?.location{
                descText = getAddress(location)
            }else{
                descText = " "
            }
            break
        case 7:
            descText = relatedContact?.name.last ?? " "
            break
        case 8:
            descText = relatedContact?.cell ?? " "
            break
        default:
            break
        }
        cell.descLabel.text = descText
        return cell
    }
    
    func getAddress(_ location:Location) -> String{
        return location.state + " " + location.city + " " + location.street
    }
    
}
