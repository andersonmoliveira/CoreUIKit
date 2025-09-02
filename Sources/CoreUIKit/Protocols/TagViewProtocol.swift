//
//  TagViewProtocol.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 30/08/25.
//

import UIKit

// MARK: - TagViewProtocol

/// Protocolo que define a interface pública de uma `TagView`.
///
/// Permite configurar a view com um título e definir a cor de fundo.
public protocol TagViewProtocol: ComponentProtocol {
    
    /// Cor de fundo da tag
    var backgroundColor: UIColor? { get set }
    
    /// Configura a tag com o título
    /// - Parameter title: Texto a ser exibido na tag
    func setupView(title: String)
}
