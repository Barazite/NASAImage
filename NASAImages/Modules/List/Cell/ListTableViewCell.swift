//
//  ListTableViewCell.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 20/4/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
       
    @IBOutlet weak var myNasaImage: UIImageView!
    @IBOutlet weak var myNasaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView(){
        self.myNasaImage.layer.cornerRadius = 8
        self.myNasaImage.layer.borderWidth = 1
        self.myNasaImage.layer.borderColor = UIColor.gray.cgColor
    }
    
    internal func configCell(data: NasaItem){
        self.myNasaLabel.text = data.title?.uppercased()
        Task{
            guard let url = URL(string: data.urlImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                self.myNasaImage.image = UIImage(named: "logo")
                return
            }
            do{
                self.myNasaImage.image = try await NasaManager().fetchPhoto(url: url)
            }catch{
                self.myNasaImage.image = UIImage(named: "logo")
            }
        }
        
    }
}
