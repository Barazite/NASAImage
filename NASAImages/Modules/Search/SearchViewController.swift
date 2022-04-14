//
//  SearchViewController.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 12/4/22.
//

import UIKit

protocol SearchViewControllerProtocol{
    
}

class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel()
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func myTextFieldChanged(_ sender: UITextField) {
        if sender.text == ""{
            self.myButton.isEnabled = false
        }else{
            self.myButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
       
    }
    
    private func setupCollectionView(){
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
    }
}

extension SearchViewController: SearchViewControllerProtocol{

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.searchViewModel.getNumberOfRow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.searchViewModel.getItem(index: indexPath.row)
        let identifier = "Item"
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SearchCollectionViewCell
        cell.itemImage.image = UIImage(named: item)
        cell.itemLabel.text = item.uppercased()
        cell.itemImage.layer.cornerRadius = 8.0
        
        return cell
    }
}
