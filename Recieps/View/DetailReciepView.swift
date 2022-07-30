//
//  DetailReciepView.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import UIKit
import youtube_ios_player_helper

class DetailReciepView: UIView {
    var meals: Meals? {
        didSet {
            if let meals = meals {
                mealName.text = meals.strMeal
                mealCategory.text = meals.strCategory
                mealInstructions.text = meals.strInstructions
                mealImage.sd_setImage(with: URL(string: meals.strMealThumb), placeholderImage: UIImage(named: meals.strMeal))
                urlVideo = meals.strYoutube
            }
        }
    }
    
    var urlVideo: String?
    
    lazy var mealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var mealName: UILabel = .textLabel(size: 18, textColor: .darkGray)
    
    lazy var mealCategory: UILabel = .textLabel(size: 32, textColor: .darkGray)
    
    lazy var mealInstructions: UILabel = .textLabel(size: 15, textColor: .darkGray, numberOfLines: 0)
    
    lazy var playerYTView: UIView = {
        let view = UIView()
        view.size(size: CGSize(width: 300, height: 300))
        view.backgroundColor = .systemPink
        return view
    }()
    
    lazy var playerYT: YTPlayerView = {
        let player = YTPlayerView()
        player.delegate = self
        return player
    }()
    
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
        
        playerYTView.addSubview(playerYT)
        playerYT.fillSuperView()
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(mealImage)
        stackView.addArrangedSubview(mealName)
        stackView.addArrangedSubview(mealInstructions)
        stackView.addArrangedSubview(playerYTView)
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
        
        if let urlVideo = urlVideo?.youtubeID {
            _ = playerYT.load(withVideoId: urlVideo)
        }
        
        layoutIfNeeded()
    }
    
    required init(coder: NSCoder) {
        fatalError(coder.debugDescription)
    }
}

extension DetailReciepView: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

