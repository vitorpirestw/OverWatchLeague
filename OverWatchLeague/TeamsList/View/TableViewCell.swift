import UIKit

class TableViewCell : UITableViewCell {

    var nomeLabel: UILabel = {
        let nlbl = UILabel()
        nlbl.textColor = .white
        nlbl.font = .boldSystemFont(ofSize: 18)
        nlbl.translatesAutoresizingMaskIntoConstraints = false
        return nlbl
    }()


    var apelidoLabel: UILabel = {
        let albl = UILabel()
        albl.translatesAutoresizingMaskIntoConstraints = false
        albl.textColor = .white
        albl.font = .boldSystemFont(ofSize: 14)
        albl.translatesAutoresizingMaskIntoConstraints = false
        return albl
    }()

    var locationLabel: UILabel = {
        let llbl = UILabel()
        llbl.translatesAutoresizingMaskIntoConstraints = false
        llbl.textColor = .white
        llbl.font = .boldSystemFont(ofSize: 14)
        llbl.translatesAutoresizingMaskIntoConstraints = false
        return llbl
    }()

    var logoImage: UIImageView = {
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        setupLayout()
        backgroundColor = UIColor(named: "cellBackgroundColor")
    }

    func setupLayout() {

        logoViewImage.addSubview(logoImage)
        let stackView = UIStackView(arrangedSubviews: [nomeLabel, apelidoLabel,locationLabel])
        let stackViewHorizontal = UIStackView(arrangedSubviews: [stackView,logoViewImage])
        stackViewHorizontal.axis = .horizontal

        addSubview(stackViewHorizontal)
        stackViewHorizontal.topAnchor.constraint(equalTo:  topAnchor, constant: 12).isActive = true
        stackViewHorizontal.spacing = 6
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontal.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -20).isActive = true

        addSubview(stackView)
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.topAnchor.constraint(equalTo:  topAnchor, constant: 12).isActive = true
        stackView.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 20).isActive = true

        logoViewImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logoViewImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logoImage.heightAnchor.constraint(equalTo: logoViewImage.heightAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalTo: logoViewImage.widthAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
