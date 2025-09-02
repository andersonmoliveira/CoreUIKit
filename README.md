# 📦 CoreUIKit

Biblioteca modular de componentes UIKit reutilizáveis para iOS.
Criada para oferecer componentes visuais consistentes, com **estados de carregamento**, **placeholders** e **design pronto para produção**.
Ideal para projetos que precisam de **reaproveitamento de UI** e **padrões visuais unificados**.

---

## 🚀 Instalação

### Swift Package Manager

No seu `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/andersonmoliveira/CoreUIKit.git", from: "1.0.0")
]
```

E depois adicione a dependência ao seu target:

```swift
.target(
    name: "SeuApp",
    dependencies: [
        .product(name: "CoreUIKit", package: "CoreUIKit")
    ]
)
```

No Xcode:
`File > Add Packages > https://github.com/andersonmoliveira/CoreUIKit.git`

---

## 🎨 Componentes Disponíveis

---

### 🔹 1. CardView

Exibe um **cartão compacto** com:

* Poster (com placeholder e carregamento)
* Título
* Data de lançamento

**Exemplo de uso:**

```swift
let cardView = CardView()
cardView.placeholderImage = UIImage(named: "posterPlaceholder")
cardView.setupView(
    poster: UIImage(named: "poster"),
    title: "Filme Exemplo",
    releaseDate: "01/01/2025"
)
cardView.update(image: newPosterImage)
```

**Visualização do componente (adicionar imagem):**

![CardView](./Images/CardView.png)

---

### 🔹 2. LargerCardView

Exibe um **cartão de destaque** com:

* Backdrop (imagem de fundo)
* Poster (com rating e placeholder)
* Título e data de lançamento
* Overview (sinopse opcional)

**Exemplo de uso:**

```swift
let cardView = LargerCardView()
cardView.setupView(
    backdrop: UIImage(named: "backdrop"),
    poster: UIImage(named: "poster"),
    title: "Filme Exemplo",
    releaseDate: "01/01/2025",
    rating: "8.5",
    overview: "Uma sinopse do filme."
)
```

**Visualização do componente (adicionar imagem):**

![LargerCardView](./Images/LargerCardView.png)

---

### 🔹 3. StatefulImageView

Componente de imagem com **estados de carregamento**:

* `.loading` → mostra indicador
* `.empty` → mostra placeholder
* `.success(image:)` → mostra imagem carregada

**Exemplo de uso:**

```swift
let imageView = StatefulImageView()
imageView.placeholderImage = UIImage(named: "placeholder")
imageView.state = .loading

// depois de carregar a imagem:
imageView.state = .success(image: loadedImage)
```

**Visualização do componente (adicionar imagem):**

![StatefulImageView](./Images/StatefulImageView.png)

---

### 🔹 4. TagView

Componente de **rótulo estilizado** (chip/tag) com arredondamento automático e sombra.

**Exemplo de uso:**

```swift
let tag = TagView()
tag.setupView(title: "Suspense")
tag.backgroundColor = .black
```

**Visualização do componente (adicionar imagem):**

![TagView](./Images/TagView.png)

---

## 🛠️ Roadmap

* [ ] Suporte a temas customizados
* [ ] Mais componentes visuais (ex.: botões, banners, listas)

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
