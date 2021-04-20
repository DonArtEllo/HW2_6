//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артем on 27.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    public var userNotLoggedInMark = true
    
    private var logInViewController = LogInViewController()
    private let reusedID = "cellID"
    
    private let profilePostsTableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        setupTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
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
        profilePostsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            profilePostsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profilePostsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profilePostsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profilePostsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

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
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHeaderView.self)) as? ProfileTableHeaderView else { return nil }

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
