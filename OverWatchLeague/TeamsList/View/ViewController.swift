//
//  ViewController.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 01/10/20.
//

import UIKit
import EzImageLoader

class ViewController: UIViewController {

    private let tableView = UITableView()
    private var presenter = TeamsPresenter()

    private var logoOverwatch: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    private let logo = UIImage(named: "logo")
    
    private let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(named: "BackgroundColor")
        return container
    }()

    private let oneLineView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .orange
        return container
    }()
    
    private let viewImage: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .green
        return container
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "OVERWATCH TEAMS DATABASE"
        title.textColor = .white
        title.font = .boldSystemFont(ofSize: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.updateView()
        addViews()
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

    private func addViews() {
        view.addSubview(containerView)
        logoOverwatch = UIImageView(image: logo)
        viewImage.addSubview(logoOverwatch)
        stackView = UIStackView(arrangedSubviews: [viewImage, titleLabel])
        containerView.addSubview(stackView)
        containerView.addSubview(oneLineView)
        containerView.addSubview(tableView)
    }

    func updateUI() {


        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            logoOverwatch.topAnchor.constraint(equalTo: viewImage.topAnchor),
            logoOverwatch.trailingAnchor.constraint(equalTo: viewImage.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: viewImage.topAnchor, constant: 55),
            oneLineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            oneLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            oneLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            oneLineView.heightAnchor.constraint(equalToConstant: 10),
            tableView.topAnchor.constraint(equalTo: oneLineView.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fill
        stackView.spacing = 8

        tableView.translatesAutoresizingMaskIntoConstraints = false
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

