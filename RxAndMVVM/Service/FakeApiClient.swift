//
//  FakeApiClient.swift
//  RxAndMVVM
//
//  Created by 金融研發一部-蔡彥佑 on 2022/1/28.
//

import Foundation

public struct ApiClient {
    
    static func getDataFromServer( complete: @escaping (_ success: Bool, _ data: [Data]? )->() ){
        DispatchQueue.global().async {
            sleep(2)
            var dummyData: [Data] = [Data]()
            for i in 0...100{
                dummyData.append(Data(title: "This is a title \(i)", subTitle: "This is a subtitle"))
            }
            complete(true, dummyData)
            // If server gives an error, use "complete(false, nil)"
        }
    }
}
