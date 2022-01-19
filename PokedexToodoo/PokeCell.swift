//
//  PokeCell.swift
//  PokedexToodoo
//
//  Created by user209844 on 13/01/22.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imagePoke: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 10
            }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
        
        public func configure(with model: Pokemon) {
            imagePoke.download(from: model.linkImg)
            nameLabel.text = model.nome
            idLabel.text = "#" + String(model.id)
            self.layer.borderColor = hexStringToUIColor(hex: model.tipo[0].cor).cgColor
            nameLabel.backgroundColor = hexStringToUIColor(hex: model.tipo[0].cor)
            idLabel.textColor = hexStringToUIColor(hex: model.tipo[0].cor)
        
        }
    
}
