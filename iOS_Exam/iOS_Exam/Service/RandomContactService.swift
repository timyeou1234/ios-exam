//
//  RandomUserService.swift
//  iOS_Exam
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit
import Alamofire

enum APIError: String, Error {
    case loading        = "載入中"
    case networlFailed  = "網路請求失敗，請點擊右上角刷新"
    case decodeFailed   = "資料解析錯誤，請點擊右上角刷新"
}

protocol RandomContactServiceProtocol{
    func fetchRandomContact( complete: @escaping ( _ success: Bool, _ contacts: [ContactModel]?, _ error: APIError? )->() )
}

class RandomContactService: RandomContactServiceProtocol{
    
    var contactList:[ContactModel]?
    
    func fetchRandomContact( complete: @escaping ( _ success: Bool, _ contacts: [ContactModel]?, _ error: APIError? )->() ){
        Alamofire.request(RandomUserUrl).responseJSON {
            (response) in
            if let _ = response.error{
                ///獲取失敗，網路錯誤
                complete(false, nil, APIError.networlFailed)
                return
            }
            if let _ = response.result.value{
                ///獲取成功
                if let contactList = self.decodeJsonData(response){
                    ///解碼成功
                    complete(true, contactList, nil)
                }else{
                    complete(false, nil, APIError.decodeFailed)
                }
                return
            }
        }
    }
    
    func decodeJsonData(_ response: DataResponse<Any>) -> [ContactModel]?{
        if let json: NSDictionary = response.result.value as? NSDictionary{
            if let contactJsonList = json["results"] as? [Any]{
                do{
                    let contactData = try JSONSerialization.data(withJSONObject: contactJsonList, options: [])
                    let decoder = JSONDecoder()
                    do{
                        ///資料解析成功
                        let contactList = try decoder.decode([ContactModel].self, from: contactData)
                        ///data 存入 UserDefault 中
                        UserDefaults.standard.set(contactData, forKey: ContactDataUserDefualtKey)
                        return contactList
                    }catch{
                        ///映射失敗
                        print("Error \(error)")
                        return nil
                    }
                }catch{
                    ///序列化失敗
                    return nil
                }
            }
        }
        ///資料格式不符合預期
        return nil
    }
    
}
