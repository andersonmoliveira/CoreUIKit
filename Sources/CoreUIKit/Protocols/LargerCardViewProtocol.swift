//
//  LargerCardViewProtocol.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 30/08/25.
//

import UIKit

// MARK: - LargerCardViewProtocol

/// Protocolo que define a interface pública de um cartão maior de filme ou mídia.
///
/// Permite configurar:
/// - Imagem de fundo (backdrop)
/// - Poster do filme
/// - Título, data de lançamento e avaliação
/// - Overview (descrição opcional)
/// - Estados de carregamento de imagens (loading, empty, success)
@MainActor
public protocol LargerCardViewProtocol: ComponentProtocol {
    
    /// Imagem placeholder exibida quando o estado do backdrop for `.empty`
    var backdropPlaceholderImage: UIImage? { get set }
    
    /// Imagem placeholder exibida quando o estado do poster for `.empty`
    var posterPlaceholderImage: UIImage? { get set }
    
    /// Configura o cartão com todas as informações
    ///
    /// - Parameters:
    ///   - backdrop: Imagem de fundo (pode ser nil)
    ///   - poster: Poster do filme (pode ser nil)
    ///   - title: Título do filme
    ///   - releaseDate: Data de lançamento do filme
    ///   - rating: Avaliação do filme
    ///   - overview: Descrição do filme (opcional)
    func setupView(backdrop: UIImage?,
                   poster: UIImage?,
                   title: String,
                   releaseDate: String,
                   rating: String,
                   overview: String?)
    
    /// Atualiza a imagem do cartão de acordo com o tipo
    ///
    /// - Parameters:
    ///   - image: Nova imagem a ser exibida
    ///   - type: Tipo da imagem a ser atualizada (`backdrop` ou `poster`)
    func update(image: UIImage, type: LargerCardImageType)
    
    /// Inicia o estado de carregamento para a imagem especificada
    ///
    /// - Parameter type: Tipo da imagem que deve entrar em estado de loading (`backdrop` ou `poster`)
    func startLoading(type: LargerCardImageType)
}
