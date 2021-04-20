//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by Артем on 13.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
        
    // MARK: Data from Storage
    var post: ProfilePagePost? {
        didSet {
            postAuthorLabel.text = post?.author
            postDescriptionLabel.text =  post?.description
            postContentImage.image = UIImage(imageLiteralResourceName: post?.image ?? "error")
            postLikesCountLabel.text = "Likes: \(post?.likes ?? 100)"
            postViewsCountLabel.text = "Views: \(post?.views ?? 150)"
        }
    }
    
    // MARK: - Post Content
    // Post's author name
    private let postAuthorLabel: UILabel = {
        let postAuthorLabel = UILabel()
        postAuthorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        postAuthorLabel.textColor = .black
        postAuthorLabel.numberOfLines = 2
        
        postAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return postAuthorLabel
    }()
    
    // Posted image
    private let postContentImage: UIImageView = {
        let postContentImage = UIImageView()
        postContentImage.contentMode = .scaleAspectFit
        postContentImage.backgroundColor = .black
        
        postContentImage.translatesAutoresizingMaskIntoConstraints = false
        
        return postContentImage
    }()
    
    // Posted image's description
    private let postDescriptionLabel: UILabel = {
        let postDescriptionLabel = UILabel()
        postDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postDescriptionLabel.textColor = .systemGray
        postDescriptionLabel.numberOfLines = 0
        
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return postDescriptionLabel
    }()
    
    // Number of likes
    private let postLikesCountLabel: UILabel = {
        let postLikesCountLabel = UILabel()
        postLikesCountLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        postLikesCountLabel.textColor = .black
        
        postLikesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return postLikesCountLabel
    }()
    
    // number of views
    private let postViewsCountLabel: UILabel = {
        let postViewsCountLabel = UILabel()
        postViewsCountLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        postViewsCountLabel.textColor = .black
        
        postViewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return postViewsCountLabel
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    // MARK: - Setup Views
    fileprivate func setupViews() {
        contentView.backgroundColor = .white
        
        contentView.addSubviews(
            postAuthorLabel,
            postContentImage,
            postDescriptionLabel,
            postLikesCountLabel,
            postViewsCountLabel
        )
        
        postAuthorLabel.sizeToFit()
        postLikesCountLabel.sizeToFit()
        postViewsCountLabel.sizeToFit()
        
        //MARK: Constraints
        let constraints = [
            
            postAuthorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            postContentImage.topAnchor.constraint(equalTo: postAuthorLabel.bottomAnchor, constant: 12),
            postContentImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postContentImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postContentImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postContentImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            postDescriptionLabel.topAnchor.constraint(equalTo: postContentImage.bottomAnchor, constant: 16),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            postLikesCountLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 16),
            postLikesCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            postViewsCountLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 16),
            postViewsCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentView.bottomAnchor.constraint(equalTo: postLikesCountLabel.bottomAnchor, constant: 16)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
