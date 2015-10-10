//
//  PersonCollectionViewswift
//  KidsApp
//
//  Created by Anna Goman on 26.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

let personReuseIdentifier = "PersonCell"

class PersonCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var pointsLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    layer.cornerRadius = rect.size.width/6
  }
  
  func configureCell(user: User) {
    nameLabel.text = user.fullName
    if user.points > 0 {
      pointsLabel.text = "+\(user.points) points"
    } else {
      pointsLabel.hidden = true
    }
    if let image = user.userImage {
      imageView.image = user.userImage
    } else {
      imageView.image = UIImage(named: "icon")
    }
  }

}
