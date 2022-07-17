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
            }
        }
    }

    lazy var viewImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var mealName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var mealCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var mealInstructions: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 100
        label.textAlignment = .justified
        label.size(size: .init(width: UIScreen.main.bounds.width, height: 200))
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupUI() {
        backgroundColor = .white

        if let image = mealImage.image {
            mealImage.image = image.resizeWithWidth(width: 200)
        }
        
        viewImage.addSubview(mealImage)
        
        mealImage.fillSuperView()
        
        let stackViewHeader = UIStackView()
        stackViewHeader.addArrangedSubview(viewImage)
        stackViewHeader.distribution = .fillEqually
        stackViewHeader.axis = .vertical
        
        addSubview(stackViewHeader)
        
        stackViewHeader.fillView(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
        
        mealImage.center = viewImage.center
        
        let stackViewMealName = UIStackView()
        stackViewMealName.addArrangedSubview(UIView())
        stackViewMealName.addArrangedSubview(mealName)
        stackViewMealName.addArrangedSubview(UIView())
        stackViewMealName.distribution = .fillEqually
        stackViewMealName.axis = .vertical
        
        addSubview(stackViewMealName)
        
        stackViewMealName.fillView(
            top: stackViewHeader.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil
        )
        
        let stackViewMealInstructions = UIStackView()
        stackViewMealInstructions.addArrangedSubview(mealInstructions)
        stackViewMealInstructions.distribution = .fillEqually
        stackViewMealInstructions.axis = .vertical
        
        addSubview(stackViewMealInstructions)
        
        stackViewMealInstructions.fillView(
            top: stackViewMealName.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 2, bottom: 0, right: -2)
        )
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
