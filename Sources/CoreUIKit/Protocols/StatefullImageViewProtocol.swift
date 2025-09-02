//
//  StatefulImageViewProtocol.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 01/09/25.
//

import UIKit

// MARK: - StatefulImageViewProtocol

/// Protocolo que define a interface pública de uma `StatefulImageView`.
///
/// Permite abstração e facilita testes e desacoplamento.
@MainActor
public protocol StatefulImageViewProtocol: ComponentProtocol {
    
    // MARK: - Propriedades
    
    /// Imagem exibida quando o estado é `.empty`
    var placeholderImage: UIImage? { get set }
    
    /// Estado atual da view
    /// - `.loading`: mostra indicador de atividade
    /// - `.empty`: mostra imagem placeholder
    /// - `.success`: mostra a imagem carregada
    var state: ImageState { get set }
    
    /// Cor de fundo da imagem
    var backgroundColor: UIColor? { get set }
    
    /// Define como a imagem será ajustada no espaço disponível
    var contentMode: UIView.ContentMode { get set }
}
