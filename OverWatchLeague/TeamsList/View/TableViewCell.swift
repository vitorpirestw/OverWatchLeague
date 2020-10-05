import UIKit

class TableViewCell : UITableViewCell {

    let nomeLabel: UILabel = {
        let nlbl = UILabel()
        nlbl.textColor = .white
        nlbl.font = .boldSystemFont(ofSize: 18)
        nlbl.translatesAutoresizingMaskIntoConstraints = false
        return nlbl
    }()


    let apelidoLabel: UILabel = {
        let albl = UILabel()
        albl.translatesAutoresizingMaskIntoConstraints = false
        albl.textColor = .white
        albl.font = .boldSystemFont(ofSize: 14)
        albl.translatesAutoresizingMaskIntoConstraints = false
        return albl
    }()

    let locationLabel: UILabel = {
        let llbl = UILabel()
        llbl.translatesAutoresizingMaskIntoConstraints = false
        llbl.textColor = .white
        llbl.font = .boldSystemFont(ofSize: 14)
        llbl.translatesAutoresizingMaskIntoConstraints = false
        return llbl
    }()

    let logoImage: UIImageView = {
        let llbl = UIImageView()
        llbl.backgroundColor = .white
        llbl.translatesAutoresizingMaskIntoConstraints = false
        return llbl
    }()

    let logoViewImage: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    var stackView = UIStackView()
    var stackViewHorizontal = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        addViews()
        setupLayout()
        backgroundColor = UIColor(named: "cellBackgroundColor")
    }

    private func addViews() {
        logoViewImage.addSubview(logoImage)
        stackView = UIStackView(arrangedSubviews: [nomeLabel, apelidoLabel,locationLabel])
        stackViewHorizontal = UIStackView(arrangedSubviews: [stackView,logoViewImage])
        addSubview(stackView)
        addSubview(stackViewHorizontal)
    }

    func setupLayout() {

        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.topAnchor.constraint(equalTo:  topAnchor, constant: 12).isActive = true
        stackViewHorizontal.spacing = 6
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false

        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical

        NSLayoutConstraint.activate([
            stackViewHorizontal.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo:  topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            logoViewImage.heightAnchor.constraint(equalToConstant: 60),
            logoViewImage.widthAnchor.constraint(equalToConstant: 60),
            logoImage.heightAnchor.constraint(equalTo: logoViewImage.heightAnchor),
            logoImage.widthAnchor.constraint(equalTo: logoViewImage.widthAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
