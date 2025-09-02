//
//  StatefulImageView.swift
//  
//
//  Created by Anderson Oliveira on 31/08/25.
//

import UIKit

// MARK: - StatefulImageView

/// Uma `UIView` responsável por exibir uma imagem em diferentes estados de UI:
/// - `loading`: mostra um indicador de atividade.
/// - `empty`: exibe uma imagem de placeholder, se disponível.
/// - `success`: exibe a imagem carregada com sucesso.
///
/// Use esta view quando o carregamento da imagem puder demorar ou falhar,
/// garantindo um feedback visual claro para o usuário.
///
/// Exemplo de uso:
/// ```swift
/// let imageView = StatefulImageView()
/// imageView.placeholderImage = UIImage(named: "placeholder")
/// imageView.state = .loading
///
/// // Após obter a imagem:
/// imageView.state = .success(image: loadedImage)
/// // ou, se não houver imagem:
/// imageView.state = .empty
/// ```
public class StatefulImageView: UIView, StatefulImageViewProtocol {
    
    // MARK: - Subviews
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    // MARK: - Propriedades Públicas
    
    /// Imagem que será exibida no estado `.empty`.
    public var placeholderImage: UIImage?
    
    /// Estado atual da view.
    /// Alterar essa propriedade atualiza automaticamente a UI.
    public var state: ImageState = .loading {
        didSet { updateUI() }
    }

    /// Cor de fundo da imagem exibida.
    /// Sobrescreve a propriedade da `UIView` base para aplicar no `imageView`.
    public override var backgroundColor: UIColor? {
        get { imageView.backgroundColor }
        set { imageView.backgroundColor = newValue }
    }

    /// Define como a imagem será ajustada dentro do espaço disponível.
    /// Exemplo: `.scaleAspectFit`, `.scaleAspectFill`.
    public override var contentMode: ContentMode {
        get { imageView.contentMode }
        set { imageView.contentMode = newValue }
    }
    
    // MARK: - Inicialização

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    /// Configura a aparência inicial da view.
    private func setupUI() {
        super.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    /// Adiciona e aplica as constraints das subviews.
    private func setupConstraints() {
        addSubview(imageView)
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Atualização de Estado
    
    /// Atualiza a UI de acordo com o estado atual definido em `state`.
    private func updateUI() {
        imageView.isHidden = true
        activityIndicator.stopAnimating()
        
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .empty:
            imageView.isHidden = false
            imageView.image = placeholderImage
        case .success(let image):
            imageView.isHidden = false
            imageView.image = image
        }
    }
}
