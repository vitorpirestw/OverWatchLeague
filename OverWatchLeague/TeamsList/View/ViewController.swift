//
//  ViewController.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 01/10/20.
//

import UIKit

class ViewController: UIViewController {

    var presenter = TeamPresenter()
    private lazy var teamList = TeamListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = teamList
        teamList.teamListViewDelegate = self
        setupNavBar()
        teamList.setupViews()
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

// MARK: - EXTENSIONS

extension ViewController: TeamListViewDelegate {
    func updateTableView(tableView: UITableView) {
        presenter.reloadTableViewClosure = { () in
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }

    func updateView() {
        presenter.updateView()
    }

    func getcellPresenter(at indexPath: IndexPath) -> TeamWire {
        presenter.getcellPresenter(at: indexPath)
    }

    var numberOfCells: Int {
        return presenter.numberOfCells
    }

    var cellHeight: Int {
        return presenter.cellHeight
    }
}
