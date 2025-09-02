//
//  TagView.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 30/08/25.
//

import UIKit

// MARK: - TagView

/// `TagView` é um componente visual que exibe um rótulo (tag) estilizado,
/// normalmente utilizado para destacar informações em uma interface.
///
/// Ele aplica arredondamento automático (formato de cápsula) e sombra
/// para dar destaque visual.
///
/// ### Exemplo de Uso
/// ```swift
/// let tag = TagView()
/// tag.setupView(title: "Novo")
/// ```
public final class TagView: UIView, TagViewProtocol {

    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.overrideUserInterfaceStyle = .unspecified
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .caption2).withSize(12)
        return label
    }()

    /// Cor de fundo da imagem exibida.
    /// Sobrescreve a propriedade da `UIView` base para aplicar no `imageView`.
    public override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor == nil { setupUI() }
//            setupTextColor()
        }
    }

    // MARK: - Inicialização

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Chamado durante o ciclo de layout da view.
    /// Responsável por aplicar o arredondamento e a sombra.
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupRounding()
        setupTextColor()
    }
    
    // MARK: - Setup

    /// Configura o arredondamento da borda e a sombra da tag.
    private func setupRounding() {
        layer.cornerRadius = bounds.height / 2.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    /// Define a cor de fundo padrão da tag.
    private func setupUI() {
        backgroundColor = .systemRed
    }

    private func setupTextColor() {
        titleLabel.textColor = (backgroundColor?.isDarkColor ?? false) ? .white : .black
    }
    
    /// Configura as constraints da `titleLabel` dentro da tag.
    private func setupConstraints() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    // MARK: - Configuração Pública
    
    /// Define o texto a ser exibido na tag.
    /// - Parameter title: Texto que será exibido.
    ///
    /// ### Exemplo
    /// ```swift
    /// let tag = TagView()
    /// tag.setupView(title: "Premium")
    /// ```
    public func setupView(title: String) {
        titleLabel.text = title
    }
}

extension UIColor {
    /// Retorna `true` se a cor for considerada escura
    var isDarkColor: Bool {
//        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        var white: CGFloat = 0, alpha: CGFloat = 0
        getWhite(&white, alpha: &alpha)
        // Cálculo de luminância
        return white < 0.5
    }
}
