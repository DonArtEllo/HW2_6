//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артем on 27.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var userNotLoggedInMark = true
    private var animationWasShownMark = true
    private var logInViewController = LogInViewController()
    private let reusedID = "cellID"
    
    private let profilePostsTableView = UITableView(frame: .zero, style: .grouped)
    
    private let headerView = ProfileTableHeaderView()
    
    private var fullscreenBackgroundView: UIView = {
        let fullscreenBackgroundView = UIView()
        fullscreenBackgroundView.backgroundColor = .black
        
        fullscreenBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        return fullscreenBackgroundView
    }()
    
    private var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = #imageLiteral(resourceName: "cat")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
            
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.alpha = 0
        
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        return avatarImageView
    }()
    
    let crossImage: UIImageView = {
        let crossImage = UIImageView()
        crossImage.image = UIImage(systemName: "multiply")

        crossImage.isUserInteractionEnabled = true
        crossImage.translatesAutoresizingMaskIntoConstraints = false

        return crossImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        setupTableView()
        setupGestures()
        
        fullscreenBackgroundView.alpha = 0
        crossImage.alpha = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        avatarImageView.layer.cornerRadius = view.bounds.width * 0.3 / 2
        
        if (userNotLoggedInMark) {
            logInViewOpener()
        }
    }
    
    // MARK: LogInView
    private func logInViewOpener() {
        navigationController?.pushViewController(logInViewController, animated: true)
        userNotLoggedInMark = false
    }
    
    private func setupTableView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray6
        
        profilePostsTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        profilePostsTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: reusedID)
        profilePostsTableView.register(
            ProfileTableHeaderView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHeaderView.self)
        )
        profilePostsTableView.dataSource = self
        profilePostsTableView.delegate = self
    }
    
    // MARK: Setup Constraints
    private func setupConstraints() {
        view.addSubview(profilePostsTableView)
        view.addSubviews(fullscreenBackgroundView,avatarImageView, crossImage)
        fullscreenBackgroundView.frame = .init(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )
        profilePostsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            profilePostsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profilePostsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profilePostsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profilePostsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            crossImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.width * 0.05),
            crossImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * view.bounds.width * 0.05),
            crossImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            crossImage.heightAnchor.constraint(equalTo: crossImage.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Setup Gestures
    private func setupGestures() {
        // Tap on AvatarImage Gesture
        let tapOnAvatarImageGusture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage))
        headerView.avatarImageView.addGestureRecognizer(tapOnAvatarImageGusture)
        headerView.avatarImageView.isUserInteractionEnabled = true
        
        // Tap on background of AvatarFullscreenView
        let tapOnBackroundFullscreenGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnBackground))
        fullscreenBackgroundView.addGestureRecognizer(tapOnBackroundFullscreenGesture)
        
        let tapOnCrossImageGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnCrossImage))
        crossImage.addGestureRecognizer(tapOnCrossImageGesture)
    }
    
    // Tap on Avatar
    @objc func tapOnAvatarImage() {
        print("You tapped avatar image")
        if animationWasShownMark {
            avatarImageView.alpha = 1
            avatarImageBecomeFullscreenBasicAnimation()
            avatarImageView.isUserInteractionEnabled = false
            fullscreenBackgroundView.isUserInteractionEnabled = true
            crossImage.isUserInteractionEnabled = true
            fullscreenBackgroundView.alpha = 0.5
            crossImage.alpha = 1
        } else {
            print("!!!SOMETHING IS WRONG!!!")
            avatarImageView.isUserInteractionEnabled = true
        }
        animationWasShownMark.toggle()
    }
    
    // Tap on fullscreen background
    @objc func tapOnBackground() {
        print("I'M NOT A CROSS")
    }
    
    // Tap on cross
    @objc func tapOnCrossImage() {
        print("You tapped cross")
        avatarImageBackToNormalBasicAnimation()
        fullscreenBackgroundView.alpha = 0
        crossImage.alpha = 0
        avatarImageView.alpha = 0
        animationWasShownMark.toggle()
        avatarImageView.isUserInteractionEnabled = true
        fullscreenBackgroundView.isUserInteractionEnabled = false
        crossImage.isUserInteractionEnabled = false
    }
    
    // MARK: - Animations
    
    
    
    // MARK: Avatar become fullscreen animation
    func avatarImageBecomeFullscreenBasicAnimation() {
        let centerXPositionAnimation = CABasicAnimation(keyPath: "position.x")
        centerXPositionAnimation.toValue = view.bounds.maxX / 2

        let centerYPositionAnimation = CABasicAnimation(keyPath: "position.y")
        centerYPositionAnimation.toValue = view.bounds.maxY / 2

        let xScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleAnimation.fromValue = 1
        xScaleAnimation.toValue = 3

        let yScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleAnimation.fromValue = 1
        yScaleAnimation.toValue = 3
        
        let avatarAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        avatarAlphaAnimation.fromValue = 0.5
        avatarAlphaAnimation.toValue = 1
        
        let avatarCornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        avatarCornerRadiusAnimation.fromValue = avatarImageView.layer.cornerRadius
        avatarCornerRadiusAnimation.toValue = 0
        
        let groupForAvatar = CAAnimationGroup()
        groupForAvatar.animations = [centerXPositionAnimation, centerYPositionAnimation, xScaleAnimation, yScaleAnimation, avatarAlphaAnimation, avatarCornerRadiusAnimation]

        groupForAvatar.duration = 0.5
        groupForAvatar.isRemovedOnCompletion = false
        groupForAvatar.fillMode = .forwards

        avatarImageView.layer.add(groupForAvatar, forKey: "image animation")
        
        let backgroundAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAlphaAnimation.fromValue = 0
        backgroundAlphaAnimation.toValue = 0.5
        
        let groupForBackground = CAAnimationGroup()
        groupForBackground.animations = [backgroundAlphaAnimation]
        
        groupForBackground.duration = 0.5
        groupForBackground.isRemovedOnCompletion = false
        groupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(groupForBackground, forKey: "background animation")
        
        let crossDelayAnimation = CABasicAnimation(keyPath: "opacity")
        crossDelayAnimation.fromValue = 0
        crossDelayAnimation.toValue = 0
        
        let groupForDelay = CAAnimationGroup()
        groupForDelay.animations = [crossDelayAnimation]
        
        groupForDelay.duration = 0.5
        
        crossImage.layer.add(groupForDelay, forKey: "delay animation")
        
        let crossImageAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        crossImageAlphaAnimation.fromValue = 0
        crossImageAlphaAnimation.toValue = 1
        
        let groupForCross = CAAnimationGroup()
        groupForCross.animations = [crossImageAlphaAnimation]
        
        groupForCross.beginTime = CACurrentMediaTime() + 0.5
        groupForCross.duration = 0.3
        groupForCross.isRemovedOnCompletion = false
        groupForCross.fillMode = .forwards
        
        crossImage.layer.add(groupForCross, forKey: "cross image animation")
    }
    
    // MARK: Avatar become back to normal animation
    func avatarImageBackToNormalBasicAnimation() {
        let centerXPositionAnimation = CABasicAnimation(keyPath: "position.x")
        centerXPositionAnimation.fromValue = view.bounds.maxX / 2
        centerXPositionAnimation.toValue = avatarImageView.center.x

        let centerYPositionAnimation = CABasicAnimation(keyPath: "position.y")
        centerYPositionAnimation.fromValue = view.bounds.maxY / 2
        centerYPositionAnimation.toValue = avatarImageView.center.y

        let xScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleAnimation.fromValue = 3
        xScaleAnimation.toValue = 1

        let yScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleAnimation.fromValue = 3
        yScaleAnimation.toValue = 1
        
        let avatarAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        avatarAlphaAnimation.fromValue = 1
        avatarAlphaAnimation.toValue = 0
        
        let avatarCornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        avatarCornerRadiusAnimation.fromValue = 0
        avatarCornerRadiusAnimation.toValue = avatarImageView.layer.cornerRadius
        
        let groupForAvatar = CAAnimationGroup()
        groupForAvatar.animations = [centerXPositionAnimation, centerYPositionAnimation, xScaleAnimation, yScaleAnimation, avatarAlphaAnimation, avatarCornerRadiusAnimation]

        groupForAvatar.duration = 0.5
        groupForAvatar.isRemovedOnCompletion = false
        groupForAvatar.fillMode = .forwards

        avatarImageView.layer.add(groupForAvatar, forKey: "image animation")
        
        let backgroundAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAlphaAnimation.fromValue = 0.5
        backgroundAlphaAnimation.toValue = 0
        
        let groupForBackground = CAAnimationGroup()
        groupForBackground.animations = [backgroundAlphaAnimation]
        
        groupForBackground.duration = 0.5
        groupForBackground.isRemovedOnCompletion = false
        groupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(groupForBackground, forKey: "background animation")
        
        let crossImageAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        crossImageAlphaAnimation.fromValue = 1
        crossImageAlphaAnimation.toValue = 0
        
        let groupForCross = CAAnimationGroup()
        groupForCross.animations = [crossImageAlphaAnimation]
        
        groupForCross.duration = 0.5
        groupForCross.isRemovedOnCompletion = false
        groupForCross.fillMode = .forwards
        
        crossImage.layer.add(groupForCross, forKey: "background animation")
    }
    
}

// MARK: Extensions
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return view.bounds.width * 0.3 + 130
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return Storage.postsTabel[0].postsOnProfilePage.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let photoSectionTableViewCell = tableView.dequeueReusableCell(withIdentifier:  String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            
            return photoSectionTableViewCell
        } else {
            let postsSectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: reusedID, for: indexPath) as! ProfileTableViewCell
            
            let post = Storage.postsTabel[0].postsOnProfilePage[indexPath.row]
            
            postsSectionTableViewCell.post = post
            
            return postsSectionTableViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.headerView

        headerView.section = Storage.postsTabel[section]

        return headerView
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.section == 0) {
            let photoCollectionViewController = PhotosViewController()
            navigationController?.pushViewController(photoCollectionViewController, animated: true)
        } else {
            return
        }
    }
}
