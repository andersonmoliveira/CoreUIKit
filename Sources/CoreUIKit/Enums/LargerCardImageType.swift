//
//  LargerCardImageType.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 30/08/25.
//

import Foundation

// MARK: - LargerCardImageType

/// Define os tipos de imagem que podem ser exibidos em um card maior.
///
/// Essa enumeração é utilizada para diferenciar os formatos de imagem
/// que podem ser apresentados, permitindo configurar se o card exibirá
/// uma imagem no formato de pôster ou no formato de backdrop.
public enum LargerCardImageType {
    
    /// Representa uma imagem no formato backdrop.
    case backdrop
    
    /// Representa uma imagem no formato pôster.
    case poster
}

