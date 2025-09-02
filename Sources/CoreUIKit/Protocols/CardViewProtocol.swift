//
//  CardViewProtocol.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 29/08/25.
//

import UIKit

// MARK: - CardViewProtocol

/// Protocolo que define a interface pública de um cartão compacto de filme ou mídia.
///
/// Permite configurar:
/// - Poster do filme (imagem opcional)
/// - Título
/// - Data de lançamento
///
/// Usado para abstrair a implementação de diferentes tipos de cartões,
/// facilitando composição de UI e reutilização.
public protocol CardViewProtocol: ComponentProtocol {
    
    /// Configura o cartão com as informações do filme
    /// - Parameters:
    ///   - poster: Imagem do poster (pode ser nil)
    ///   - title: Título do filme
    ///   - releaseDate: Data de lançamento
    func setupView(poster: UIImage?, title: String, releaseDate: String)
    
    /// Atualiza a imagem do poster
    /// - Parameter image: Nova imagem a ser exibida
    func update(image: UIImage)

    /// Inicia o estado de carregamento para a imagem
    func startLoading()
}
