//
//  FavoritesTableViewCell.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 6/5/22.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myFavImage: UIImageView!
    @IBOutlet weak var myFavLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupView(){
        self.myFavImage.layer.cornerRadius = 8
        self.myFavImage.layer.borderWidth = 1
        self.myFavImage.layer.borderColor = UIColor.gray.cgColor
    }
    
    internal func configCell(data: NasaItem){
        self.myFavLabel.text = data.title?.uppercased()
        Task{
            guard let url = URL(string: data.urlImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                self.myFavImage.image = UIImage(named: "logo")
                return
            }
            do{
                self.myFavImage.image = try await NasaManager().fetchPhoto(url: url)
            }catch{
                self.myFavImage.image = UIImage(named: "logo")
            }
        }
        
    }
}
