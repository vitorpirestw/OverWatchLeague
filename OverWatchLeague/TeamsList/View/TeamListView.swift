import UIKit
import EzImageLoader

final class TeamListView: UIView {

    lazy var teamListViewPresenter = ViewController().presenter

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        return tableView
    }()


    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BackgroundColor")
        return view
    }()

    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(tableView)
        teamListViewPresenter.updateView()
        updateConstraint()
    }

    func updateTableView() {
        teamListViewPresenter.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func updateConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor),

            tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 80),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }
}

extension TeamListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamListViewPresenter.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let team = teamListViewPresenter.getcellPresenter(at: indexPath)
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
        return CGFloat(teamListViewPresenter.cellHeight)
    }
}
