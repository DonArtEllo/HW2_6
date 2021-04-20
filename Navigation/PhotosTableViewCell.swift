//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Артем on 16.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let mainIndent: CGFloat = 12
    private let spacer: CGFloat = 8
    
    // MARK: - Photos Section Content
    // "Photos" text
    private let photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Photos"
        photosLabel.font = UIFont.boldSystemFont(ofSize: 24)
        photosLabel.textColor = .black

        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return photosLabel
    }()
    
    // Arrow image
    private let pointerImageView: UIImageView = {
        let pointerImageView = UIImageView()
        pointerImageView.image = UIImage.init(systemName: "arrow.right")
        
        pointerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pointerImageView
    }()
    
    // Photos' scroll
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
        
        collectionView.register(PhotosProfileCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosProfileCollectionViewCell.self))
        
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
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
    private func setupViews() {
        contentView.backgroundColor = .white
        
        contentView.addSubviews(
            photosLabel,
            pointerImageView,
            collectionView
        )
//        scrollView.addSubview(containerView)
//        containerView.addSubview(collectionView)
        
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        photosLabel.sizeToFit()
        
        //MARK: Constraints
        let constraints = [
            
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: mainIndent),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mainIndent),
            
            pointerImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            pointerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1 * mainIndent),
            
//            scrollView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: mainIndent),
//            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mainIndent),
//            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1 * mainIndent),
//            scrollView.heightAnchor.constraint(equalToConstant: (CGFloat(superview?.bounds.width ?? 414) - (mainIndent * 2 + spacer * 3)) / 4),
//
//            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            containerView.widthAnchor.constraint(equalToConstant: ((CGFloat(superview?.bounds.width ?? 414) - (mainIndent * 2 + spacer * 3)) / 4) * 20 - spacer * 5),
//            containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
//
//            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: mainIndent),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mainIndent),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1 * mainIndent),
            collectionView.heightAnchor.constraint(equalToConstant: floor((CGFloat(superview?.bounds.width ?? 414) - (mainIndent * 2 + spacer * 3)) / 4) - 1),
            
            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: mainIndent)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.photosTabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosProfileCollectionViewCell.self), for: indexPath) as! PhotosProfileCollectionViewCell
        
        let photo = Storage.photosTabel[indexPath.row]
        
        cell.photo = photo
        
        cell.layer.cornerRadius = 6
        
        return cell
    }
    
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizeOfCell = floor((CGFloat(superview?.bounds.width ?? 414)  - (mainIndent * 2 + spacer * 3)) / 4) - 1
        
        return CGSize(width: sizeOfCell, height: sizeOfCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacer
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
