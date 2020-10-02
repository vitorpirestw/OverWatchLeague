//
//  ViewController.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 01/10/20.
//

import UIKit
import EzImageLoader

class ViewController: UIViewController {

    let tableView = UITableView()
    var safeArea = UILayoutGuide()
    var interactor = TeamInteractor()
    var presenter = TeamsPresenter()

    var logoOverwatch: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    let logo = UIImage(named: "logo")
    
    let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(named: "BackgroundColor")
        return container
    }()

    let oneLineView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .orange
        return container
    }()
    
    let viewImage: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .green
        return container
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "OVERWATCH TEAMS DATABASE"
        title.textColor = .white
        title.font = .boldSystemFont(ofSize: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.updateView()
        updateUI()
        updateTableView()
    }

    func updateTableView() {
        presenter.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func updateUI() {

        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        logoOverwatch = UIImageView(image: logo)
        viewImage.addSubview(logoOverwatch)

        logoOverwatch.topAnchor.constraint(equalTo: viewImage.topAnchor).isActive = true
        logoOverwatch.trailingAnchor.constraint(equalTo: viewImage.trailingAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [viewImage, titleLabel])
        containerView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: viewImage.topAnchor, constant: 55).isActive = true

        containerView.addSubview(oneLineView)
        oneLineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        oneLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        oneLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        oneLineView.heightAnchor.constraint(equalToConstant: 10).isActive = true

        containerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: oneLineView.bottomAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let team = presenter.getcellPresenter(at: indexPath)
        cell.nomeLabel.text = team.name.uppercased()
        cell.apelidoLabel.text = team.abbreviatedName.uppercased()
        cell.locationLabel.text = team.location.uppercased()

        if let urlString = team.logo.main.png{
            ImageLoader.get(urlString) {cell.logoImage.image = $0.image}
        } else {
            print("no image")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(presenter.cellHeight)
    }
}

