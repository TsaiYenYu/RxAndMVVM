//
//  ViewModel.swift
//  RxAndMVVM
//
//  Created by 金融研發一部-蔡彥佑 on 2022/1/28.
//

import UIKit

class DataViewModel {
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var datas: [Data] = [Data]()

    
    private var cellViewModels: [DataListCellViewModel] = [DataListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getData(){
        showLoading?()
        ApiClient.getDataFromServer { (success, data) in
            self.hideLoading?()
            if success {
                self.createCell(datas: data!)
                self.reloadTableView?()
            } else {
                self.showError?()
            }
        }
    }

    
    func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(datas: [Data]){
        self.datas = datas
        var vms = [DataListCellViewModel]()
        for data in datas {
            vms.append(DataListCellViewModel(titleText: data.title, subTitleText: data.subTitle))
        }
        cellViewModels = vms
    }

}
