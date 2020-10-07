//
//  ViewController.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 01/10/20.
//

import UIKit

class ViewController: UIViewController {

    var presenter = TeamsPresenter()
    lazy var teamList = TeamListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = teamList
        teamList.setupViews()
        teamList.setupNavBar(vc: self)
        teamList.updateTableView()
    }
}

