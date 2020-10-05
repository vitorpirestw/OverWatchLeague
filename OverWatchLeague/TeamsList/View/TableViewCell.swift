import UIKit

class TableViewCell : UITableViewCell {

    let nomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    let apelidoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let logoViewImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var stackView = UIStackView()

    var stackViewHorizontal = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        addViews()
        backgroundColor = UIColor(named: "cellBackgroundColor")
    }

    private func addViews() {
        logoViewImage.addSubview(logoImage)
        stackView = UIStackView(arrangedSubviews: [nomeLabel, apelidoLabel,locationLabel])
        stackViewHorizontal = UIStackView(arrangedSubviews: [stackView,logoViewImage])
        addSubview(stackView)
        addSubview(stackViewHorizontal)

        updateConstraint()
    }

    func updateConstraint() {

        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.spacing = 16
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackViewHorizontal.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -20),
            stackViewHorizontal.topAnchor.constraint(equalTo:  topAnchor, constant: 12),
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
