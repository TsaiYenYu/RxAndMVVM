//
//  RxViewController.swift
//  RxAndMVVM
//
//  Created by 金融研發一部-蔡彥佑 on 2022/1/28.
//

import UIKit
import RxSwift
import RxCocoa



class RxViewController: UIViewController,UITableViewDelegate {

    var dataViewModel = DataViewModel()
    var mainTableView:UITableView = UITableView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewModel.getDataDelay{
            self.initData()
            self.initView()
            self.initEvent()
        }
        // Do any additional setup after loading the view.
    }

    
    func initData(){
    }

    
    func initView(){
        navigationController?.navigationBar.barStyle = .black
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.title = "Rx"
        view.addSubview(mainTableView)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")
        mainTableView.delegate = self
    }
    
    func initEvent(){
        
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.mainTableView.reloadData() }
        }
        
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("檢查程式碼") }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
        
        let items = Observable.just(self.dataViewModel.datas)
        items.bind(to: self.mainTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as! CustomTableViewCell
            cell.lblSubTitle.isHidden = true
            cell.lblTitle.isHidden = true
            cell.textLabel?.text = "\(row)：\(element.title)"
            return cell
        }
        .disposed(by: self.disposeBag)
        
        mainTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("indexPath：\(indexPath)")
        }).disposed(by: disposeBag)
         
        mainTableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("row title：\(item)")
        }).disposed(by: disposeBag)
    }

}


extension RxViewController {
        
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
