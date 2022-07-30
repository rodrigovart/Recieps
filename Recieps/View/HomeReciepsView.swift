//
//  HomeReciepsView.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import UIKit
import SDWebImage

class HomeReciepsView: UITableViewCell {    
    var meals: Meals? {
        didSet {
            if let meals = meals {
                mealImage.sd_setImage(with: URL(string: meals.strMealThumb), placeholderImage: UIImage(named: meals.strMealThumb))
                mealName.text = meals.strMeal
                mealCategory.text = meals.strCategory
                mealInstructions.text = meals.strInstructions
            }
        }
    }
    
    lazy var mealImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    lazy var mealName: UILabel = .textLabel(size: 18, textColor: .darkGray)
    
    lazy var mealCategory: UILabel = .textLabel(size: 20, textColor: .darkGray)
    
    lazy var mealInstructions: UILabel = .textLabel(size: 15, textColor: .darkGray, numberOfLines: 2)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let image = mealImage.image {
            mealImage.image = image.resizeWithWidth(width: 100)
        }

        mealImage.layer.cornerRadius = 20
        mealImage.layer.masksToBounds = true
        mealImage.addShadow()
                
        let stackView = UIStackView()
        stackView.addArrangedSubview(mealImage)
        stackView.addArrangedSubview(mealName)
        stackView.addArrangedSubview(UIView())
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        let stackViewWithInstructions = UIStackView()
        stackViewWithInstructions.addArrangedSubview(stackView)
        stackViewWithInstructions.addArrangedSubview(mealInstructions)
        
        stackViewWithInstructions.axis = .vertical
        stackViewWithInstructions.spacing = 10
        stackViewWithInstructions.distribution = .fillEqually
        
        addSubview(stackViewWithInstructions)
        
        stackViewWithInstructions.fillView(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 10, left: 10, bottom: -10, right: -10)
        )
        
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

