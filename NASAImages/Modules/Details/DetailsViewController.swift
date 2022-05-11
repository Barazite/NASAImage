//
//  DetailsViewController.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 27/4/22.
//

import UIKit

protocol DetailsViewControllerProtocol {
    
}
class DetailsViewController: UIViewController {
    
    var detailsViewModel: DetailsViewModelProtocol?
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var myLocationLabel: UILabel!
    @IBOutlet weak var myDescriptionLabel: UILabel!
    @IBOutlet weak var myFavButton: UIButton!
    
    @IBAction func favButtonAction(_ sender: Any) {
        if self.detailsViewModel!.checkFav(){
            self.detailsViewModel?.deleteItem()
        }else{
            self.detailsViewModel?.saveItem()
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configView()
        configButtonFav()
    }
    
    func configView(){
        let item = self.detailsViewModel?.getItem()
        
        Task{
            guard let url = URL(string: item?.urlImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                self.myImage.image = UIImage(named: "logo")
                return
            }
            do{
                self.myImage.image = try await NasaManager().fetchPhoto(url: url)
            }catch{
                self.myImage.image = UIImage(named: "logo")
            }
        }
        self.myDateLabel.text = item?.date
        self.myLocationLabel.text = item?.location
        self.myDescriptionLabel.text = item?.descriptionNasa
    }
    
    func configButtonFav(){
        if self.detailsViewModel!.checkFav() {
            self.myFavButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            self.myFavButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
