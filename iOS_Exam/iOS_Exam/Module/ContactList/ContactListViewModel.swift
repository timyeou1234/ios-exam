//
//  ContactListViewModel.swift
//  iOS_Exam
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class ContactListViewModel {
    
    let randomContactService :RandomContactServiceProtocol
    
    private var contactList :[ContactModel] = [ContactModel]()
    
    private var cellViewModels :[ContactListCellViewModel] = [ContactListCellViewModel]() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }
    
    var loadingStatus: String = "" {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var selectedContact: ContactModel?
    var relatedContact:  ContactModel?
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init( apiService: RandomContactServiceProtocol = RandomContactService()) {
        self.randomContactService = apiService
    }
    
    ///isRefresh 用於判斷是否強制刷新
    func initFetch(_ isRefresh :Bool) {
        self.loadingStatus = APIError.loading.rawValue
        if isRefresh == false{
            if let contactData = UserDefaults.standard.data(forKey: ContactDataUserDefualtKey){
                do{
                    let decoder = JSONDecoder()
                    ///資料解析成功
                    self.loadingStatus = ""
                    let contactList = try decoder.decode([ContactModel].self, from: contactData)
                    self.processContactList(contactList)
                    return
                }catch{
                    ///映射失敗執行網路操作
                }
            }
        }
        ///進行資料初始化
        self.contactList = [ContactModel]()
        self.cellViewModels = [ContactListCellViewModel]()
        UserDefaults.standard.removeObject(forKey: ContactDataUserDefualtKey)
        randomContactService.fetchRandomContact {
            (success, contactList, error) in
            if let error = error{
                ///遇到錯誤
                self.loadingStatus = error.rawValue
                return
            }
            if let fetchedList = contactList{
                self.loadingStatus = ""
                self.processContactList(fetchedList)
            }
            return
        }
    }
    
    //處理並轉化為 ViewModel
    func processContactList(_ contactList: [ContactModel]){
        self.contactList = contactList
        var cellViewModels = [ContactListCellViewModel]()
        for contact in contactList{
            cellViewModels.append(createCellViewModel(contact))
        }
        self.cellViewModels = cellViewModels
    }
    
    func createCellViewModel(_ contact: ContactModel) -> ContactListCellViewModel{
        return ContactListCellViewModel(firstNameText: contact.name.first,
                                        lastnameText: contact.name.last,
                                        titleText: contact.name.title,
                                        phoneText: contact.phone)
    }
    
    ///開放給 ViewController 取用
    func getCellViewModel( at indexPath: IndexPath ) -> ContactListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func userPressed( at indexPath: IndexPath ){
        self.selectedContact = self.contactList[indexPath.row]
        let contactIndex = (indexPath.row + 5) % self.contactList.count
        self.relatedContact = self.contactList[contactIndex]
    }
}

struct ContactListCellViewModel{
    let firstNameText   :String
    let lastnameText    :String
    let titleText       :String
    let phoneText       :String
}
