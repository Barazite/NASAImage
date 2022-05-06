//
//  FavoritesViewController.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 5/5/22.
//

import UIKit

protocol FavoritesViewControllerProtocol {
    func reloadData()
}

class FavoritesViewController: UIViewController {

    var favoritesViewModel: FavoritesViewModelProtocol?
    
    @IBOutlet weak var myFavTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoritesViewModel?.fetchData()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoritesViewModel?.fetchData()
    }
    
    private func setupTableView(){
        self.myFavTableView.delegate = self
        self.myFavTableView.dataSource = self
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemCell = sender as? FavoritesTableViewCell
        let indexPath = myFavTableView.indexPath(for: itemCell!)
        let detailsVC = segue.destination as! DetailsViewController
        let item = self.favoritesViewModel?.getItem(index: (indexPath?.row)!)
        detailsVC.detailsViewModel = DetailsViewModel(itemNasa: item!, vc: detailsVC, favCheck: true)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favoritesViewModel!.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item = self.favoritesViewModel!.getItem(index: indexPath.row)
        let identifier = "FavItem"
        let cell = myFavTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FavoritesTableViewCell
        cell.configCell(data: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol{
    func reloadData() {
        self.myFavTableView.reloadData()
    }
}
