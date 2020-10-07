//
//  ViewController.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 01/10/20.
//

import UIKit

class ViewController: UIViewController {

    var presenter = TeamsPresenter()
    private lazy var teamList = TeamListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = teamList
        setupNavBar()
        teamList.setupViews()
        teamList.updateTableView()
    }

    func setupNavBar() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "Overwatch-Symbol")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
    }
}
