//
//  ComponentProtocol.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 30/08/25.
//

import UIKit

// MARK: - ComponentProtocol

/// Um protocolo que define um contrato para componentes que podem ser
/// representados como uma `UIView`.
///
/// Esse protocolo é útil para padronizar a forma como diferentes
/// componentes customizados podem ser expostos como views,
/// facilitando composição e reutilização em hierarquias de UI.
public protocol ComponentProtocol: AnyObject {
    
    /// Retorna o componente convertido em uma instância de `UIView`.
    ///
    /// - Returns: Uma `UIView` representando o componente.
    func asView() -> UIView
}

// MARK: - Implementação Padrão para UIView

public extension ComponentProtocol where Self: UIView {
    
    /// Implementação padrão de `asView()`, que simplesmente
    /// retorna a própria instância da view.
    ///
    /// Isso evita a necessidade de implementar manualmente em
    /// todas as subclasses de `UIView` que adotarem `ComponentProtocol`.
    func asView() -> UIView { self }
}
