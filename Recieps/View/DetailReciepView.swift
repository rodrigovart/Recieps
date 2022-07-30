//
//  DetailReciepView.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import UIKit

class DetailReciepView: UIView {
    var meals: Meals? {
        didSet {
            if let meals = meals {
                mealName.text = meals.strMeal
                mealCategory.text = meals.strCategory
                mealInstructions.text = meals.strInstructions
                mealImage.sd_setImage(with: URL(string: meals.strMealThumb), placeholderImage: UIImage(named: meals.strMeal))
                urlVideo = URL(string: meals.strYoutube)!
            }
        }
    }
    
    var urlVideo: URL?

    lazy var mealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var mealName: UILabel = .textLabel(size: 18, textColor: .darkGray)
    
    lazy var mealCategory: UILabel = .textLabel(size: 32, textColor: .darkGray)
    
    lazy var mealInstructions: UILabel = .textLabel(size: 15, textColor: .darkGray, numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupUI() {
        if let image = mealImage.image {
            mealImage.image = image.sd_resizedImage(with: CGSize(width: 300, height: 300), scaleMode: .fill)
        }
        
        mealImage.centralizeSuperView()
        mealImage.addShadow()
        mealImage.layer.cornerRadius = 20
        mealImage.layer.masksToBounds = true
                
        let stackView = UIStackView()
        stackView.addArrangedSubview(mealImage)
        stackView.addArrangedSubview(mealName)
        stackView.addArrangedSubview(mealInstructions)
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        
        stackView.fillView(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 10, left: 10, bottom: -10, right: -10)
        )
        
        mealName.sizeToFit()
        mealName.textAlignment = .center
        
        mealInstructions.sizeToFit()
        mealInstructions.textAlignment = .justified
        mealInstructions.lineBreakMode = .byWordWrapping
        
        layoutIfNeeded()
    }

    required init(coder: NSCoder) {
        fatalError(coder.debugDescription)
    }
}


extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
