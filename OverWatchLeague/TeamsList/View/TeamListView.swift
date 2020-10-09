import UIKit
import EzImageLoader

// MARK: - PROTOCOLS

protocol TeamListViewDelegate {
    func updateView()
    func getcellPresenter( at indexPath: IndexPath ) -> TeamWire
    func updateTableView(tableView: UITableView)
    var numberOfCells: Int { get }
    var cellHeight: Int { get }
}

final class TeamListView: UIView {

    // MARK: - PROPERTIES

    var teamListViewDelegate: TeamListViewDelegate?

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

    // MARK: - METHODS

    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(tableView)
        teamListViewDelegate?.updateView()
        updateConstraint()
        teamListViewDelegate?.updateTableView(tableView: tableView)
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

    private func animateImage(image: UIImageView) {
        image.alpha = 0
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [ .curveLinear], animations: {
            image.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            image.alpha = 1
        }, completion: nil)
    }
}

// MARK: - EXTENSIONS

extension TeamListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamListViewDelegate!.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let team = teamListViewDelegate!.getcellPresenter(at: indexPath)
        cell.nomeLabel.text = team.name.uppercased()
        cell.apelidoLabel.text = team.abbreviatedName.uppercased()
        cell.locationLabel.text = team.location.uppercased()

        if let urlString = team.logo.main.png{
            ImageLoader.get(urlString) {cell.logoImage.image = $0.image}
            animateImage(image: cell.logoImage)
        } else {
            print("no image")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(teamListViewDelegate!.cellHeight)
    }
}

extension TeamListView: UITableViewDelegate {}
