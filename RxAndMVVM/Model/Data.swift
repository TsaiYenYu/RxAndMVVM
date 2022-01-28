//
//  Data.swift
//  RxAndMVVM
//
//  Created by 金融研發一部-蔡彥佑 on 2022/1/28.
//

import Foundation


class Data {
    var title: String
    var subTitle: String
    
    init(title: String, subTitle: String) {
        self.title = title
        self.subTitle = subTitle
    }
}

struct DataListCellViewModel {
    let titleText: String
    let subTitleText: String
}
