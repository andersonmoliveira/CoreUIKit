//
//  ImageState.swift
//  
//
//  Created by Anderson Oliveira on 31/08/25.
//

import UIKit

// MARK: - ImageState

/// Define os possíveis estados do componente de imagem.
///
/// Este enum é utilizado para representar os diferentes estados de interface
/// que uma view de imagem pode assumir, como durante o carregamento, quando
/// não há imagem disponível ou quando a imagem foi carregada com sucesso.
public enum ImageState {
    
    /// Estado em que a imagem está sendo carregada.
    case loading
    
    /// Estado em que nenhuma imagem está disponível, permitindo exibir uma imagem de placeholder.
    case empty
    
    /// Estado em que a imagem foi carregada com sucesso.
    ///
    /// - Parameter image: A imagem carregada com sucesso.
    case success(image: UIImage)
}
