//
//  CardView.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 29/08/25.
//

import UIKit

// MARK: - CardView

/// Uma `UIView` que exibe um cartão compacto com informações de filme ou mídia.
/// O cartão suporta:
/// - Poster do filme com cantos arredondados e estado de carregamento (usando `StatefulImageViewProtocol`).
/// - Título, data de lançamento e avaliação (rating).
///
/// Esta view é ideal para listas ou grids de filmes, fornecendo feedback visual consistente
/// durante o carregamento das imagens.
///
/// Exemplo de uso:
/// ```swift
/// let cardView = CardView()
/// cardView.placeholderImage = UIImage(named: "posterPlaceholder")
/// cardView.setupView(
///     poster: UIImage(named: "poster"),
///     title: "Filme Exemplo",
///     releaseDate: "01/01/2025",
/// )
/// cardView.update(image: newPosterImage)
/// ```
public final class CardView: UIView, CardViewProtocol {
    
    // MARK: - Subviews

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImageView.asView(), infoStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var posterImageView: StatefulImageViewProtocol = {
        let imageView = StatefulImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       releaseDateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline).withSize(13)
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline).withSize(9)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Placeholder Image

    /// Imagem placeholder exibida quando o poster não estiver disponível
    public var placeholderImage: UIImage? {
        get { posterImageView.placeholderImage }
        set { posterImageView.placeholderImage = newValue }
    }

    // MARK: - Init

    /// Inicializador padrão
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupRounding()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    /// Configura a aparência inicial do cartão
    private func setupUI() {
        backgroundColor = .systemBackground
    }

    /// Configura cantos arredondados e sombra do cartão
    private func setupRounding() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    /// Adiciona subviews e aplica constraints principais
    private func setupConstraints() {
        addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            posterImageView.asView().heightAnchor.constraint(equalTo: posterImageView.asView().widthAnchor, multiplier: 1.5),
            infoStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
    }

    /// Configura o estado de uma `StatefulImageView` com a imagem fornecida
    private func setupImage(_ image: UIImage?) {
        if let image {
            posterImageView.state = .success(image: image)
        } else {
            posterImageView.state = .empty
        }
    }

    // MARK: - Public Configure

    /// Configura o cartão com informações do filme
    ///
    /// - Parameters:
    ///   - poster: Imagem do poster do filme (pode ser `nil`)
    ///   - title: Título do filme
    ///   - releaseDate: Data de lançamento do filme
    public func setupView(poster: UIImage?, title: String, releaseDate: String) {
        setupImage(poster)
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
    }

    /// Atualiza a imagem do poster
    ///
    /// - Parameter image: Nova imagem a ser exibida
    public func update(image: UIImage?) {
        setupImage(image)
    }

    /// Exibe o estado de carregamento da imagem
    public func startLoading() {
        posterImageView.state = .loading
    }
}
