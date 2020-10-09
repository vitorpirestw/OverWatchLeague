import UIKit

class TableViewCell : UITableViewCell {


    // MARK: - PROPERTIES

    let nomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
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

    private var stackView = UIStackView()
    private var stackViewHorizontal = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        setupViews()
        backgroundColor = UIColor(named: "cellBackgroundColor")
        
    }

    // MARK: - METHODS
    private func setupViews() {
        stackView = UIStackView(arrangedSubviews: [nomeLabel, apelidoLabel,locationLabel])
        stackViewHorizontal = UIStackView(arrangedSubviews: [stackView,logoViewImage])

        logoViewImage.addSubview(logoImage)
        addSubview(stackViewHorizontal)
        addSubview(stackView)

        updateConstraint()
    }

    private func updateConstraint() {
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.distribution = .fill
        stackViewHorizontal.alignment = .fill
        stackViewHorizontal.spacing = 0
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackViewHorizontal.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -20),
            stackViewHorizontal.topAnchor.constraint(equalTo:  topAnchor, constant: 12),

            stackView.topAnchor.constraint(equalTo:  topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            logoViewImage.heightAnchor.constraint(equalToConstant: 50),
            logoViewImage.widthAnchor.constraint(equalToConstant: 50),
            logoViewImage.bottomAnchor.constraint(equalTo: stackViewHorizontal.bottomAnchor),
            logoViewImage.topAnchor.constraint(equalTo:  stackViewHorizontal.topAnchor, constant: 12),

            logoImage.heightAnchor.constraint(equalTo: logoViewImage.heightAnchor),
            logoImage.widthAnchor.constraint(equalTo: logoViewImage.widthAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
