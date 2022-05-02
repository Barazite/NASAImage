//
//  DetailsViewController.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 27/4/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var detailsViewModel: DetailsViewModelProtocol?
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var myLocationLabel: UILabel!
    @IBOutlet weak var myDescriptionLabel: UILabel!
   

    override func viewDidLoad(){
        super.viewDidLoad()
        configView()
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
        self.myDescriptionLabel.text = item?.description
    }

}
