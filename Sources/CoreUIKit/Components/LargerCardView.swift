//
//  LargerCardView.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 30/08/25.
//

import UIKit

// MARK: - LargerCardView

/// Uma `UIView` que exibe um cartão de destaque com informações de filme ou mídia.
/// O cartão suporta:
/// - Imagem de fundo (backdrop) com placeholder e estado de carregamento.
/// - Poster com avaliação (rating) e placeholder.
/// - Título, data de lançamento e overview (sinopse opcional).
///
/// Esta view é ideal para exibir informações detalhadas de mídia em uma interface de usuário,
/// mantendo consistência visual e estados de carregamento claros.
///
/// Exemplo de uso:
/// ```swift
/// let cardView = LargerCardView()
/// cardView.setupView(
///     backdrop: UIImage(named: "backdrop"),
///     poster: UIImage(named: "poster"),
///     title: "Filme Exemplo",
///     releaseDate: "01/01/2025",
///     rating: "8.5",
///     overview: "Uma sinopse do filme."
/// )
/// cardView.startLoading(type: .poster)
/// cardView.update(image: loadedPoster, type: .poster)
/// ```
public final class LargerCardView: UIView, LargerCardViewProtocol {
    
    // MARK: - Subviews

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerImagesView, infoStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var headerImagesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backdropImageView: StatefulImageViewProtocol = {
        let imageView = StatefulImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var posterRatingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImageView.asView(), ratingStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .lastBaseline
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var posterImageView: StatefulImageViewProtocol = {
        let imageView = StatefulImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline).withSize(30)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline).withSize(16)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingStarImageView, ratingLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var ratingStarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [overviewLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Placeholder Images
    
    /// Imagem placeholder para o backdrop
    public var backdropPlaceholderImage: UIImage? {
        get { backdropImageView.placeholderImage }
        set { backdropImageView.placeholderImage = newValue }
    }

    /// Imagem placeholder para o poster
    public var posterPlaceholderImage: UIImage? {
        get { posterImageView.placeholderImage }
        set { posterImageView.placeholderImage = newValue }
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    /// Configura a aparência inicial da view
    private func setupUI() {
        backgroundColor = .systemBackground
    }
    
    /// Adiciona as subviews e aplica as constraints principais
    private func setupConstraints() {
        addSubview(contentStackView)
        headerImagesView.insertSubview(backdropImageView.asView(), at: 0)
        headerImagesView.insertSubview(posterRatingStackView, at: 1)

        infoStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        overviewStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            backdropImageView.asView().topAnchor.constraint(equalTo: headerImagesView.topAnchor),
            backdropImageView.asView().leadingAnchor.constraint(equalTo: headerImagesView.leadingAnchor),
            backdropImageView.asView().trailingAnchor.constraint(equalTo: headerImagesView.trailingAnchor),
            backdropImageView.asView().heightAnchor.constraint(equalTo: backdropImageView.asView().widthAnchor, multiplier: 0.56),

            posterImageView.asView().centerYAnchor.constraint(equalTo: backdropImageView.asView().bottomAnchor),
            posterImageView.asView().leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            posterImageView.asView().bottomAnchor.constraint(equalTo: headerImagesView.bottomAnchor),
            posterImageView.asView().heightAnchor.constraint(equalToConstant: 225),
            posterImageView.asView().widthAnchor.constraint(equalToConstant: 150),
        ])
    }

    /// Configura o estado de uma `StatefulImageView` com a imagem fornecida.
    private func setupImage(_ image: UIImage?, imageView: StatefulImageViewProtocol) {
        if let image {
            imageView.state = .success(image: image)
        } else {
            imageView.state = .empty
        }
    }

    /// Configura o overview (sinopse) do filme
    private func setupOverview(text: String?) {
        guard let text else {
            overviewStackView.removeFromSuperview()
            return
        }
        overviewLabel.text = text
        contentStackView.addArrangedSubview(overviewStackView)
    }
    
    // MARK: - Public Methods
    
    /// Configura a view com todas as informações de filme
    public func setupView(backdrop: UIImage?,
                          poster: UIImage?,
                          title: String,
                          releaseDate: String,
                          rating: String,
                          overview: String?) {
        setupImage(backdrop, imageView: backdropImageView)
        setupImage(poster, imageView: posterImageView)
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        ratingLabel.text = rating
        setupOverview(text: overview)
    }

    /// Atualiza a imagem de acordo com o tipo especificado
    public func update(image: UIImage, type: LargerCardImageType) {
        switch type {
        case .backdrop: backdropImageView.state = .success(image: image)
        case .poster: posterImageView.state = .success(image: image)
        }
    }

    /// Exibe o estado de carregamento da imagem de acordo com o tipo
    public func startLoading(type: LargerCardImageType) {
        switch type {
        case .backdrop: backdropImageView.state = .loading
        case .poster: posterImageView.state = .loading
        }
    }
}
