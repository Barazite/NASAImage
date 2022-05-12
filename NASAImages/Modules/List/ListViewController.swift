//
//  ListViewController.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 14/4/22.
//

import UIKit

protocol ListViewControllerProtocol {
    func reloadData()
    func emptyData()
}

class ListViewController: UIViewController {
    
    var listViewModel : ListViewModelProtocol?
        
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationItem.title = self.listViewModel?.getSearchText()
        Task{
            await self.listViewModel?.fetchData()
        }
    }
    
    private func setupTableView(){
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let itemCell = sender as? ListTableViewCell
        let indexPath = myTableView.indexPath(for: itemCell!)
        let detailsVC = segue.destination as! DetailsViewController
        let item = self.listViewModel?.getItem(index: (indexPath?.row)!)
        detailsVC.detailsViewModel = DetailsViewModel(itemNasa: item!, vc: detailsVC)
    }
}

extension ListViewController: ListViewControllerProtocol{
    func reloadData() {
        self.myTableView.reloadData()
    }
    
    func emptyData(){
        self.myTableView.isHidden = true
        self.myLabel.text = "No result is found"
        self.myLabel.isHidden = false
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listViewModel!.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item = self.listViewModel!.getItem(index: indexPath.row)
        let identifier = "NasaItem"
        let cell = myTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ListTableViewCell
        cell.configCell(data: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if ((self.listViewModel?.getNumberOfRow())!-1) == indexPath.row {
            if !self.listViewModel!.checkFinalList(){
                Task{
                    await self.listViewModel?.fetchData()
                }
            }
        }
    }
}
