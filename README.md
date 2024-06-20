<div align="center"><h1>MaxTrip 🛬</div></h1>

## ✈️ Introdução
Este projeto é um aplicativo de gerenciamento de voos desenvolvido em Swift para iOS, utilizando o UIKit. Ele permite aos usuários adicionar e visualizar voos, gerenciar passageiros e tripulantes, e verificar os detalhes de cada voo.

## 📁 Estrutura das Pastas
```css
├── 📁 Controllers
│   ├── 📄 FlightViewController.swift
│   ├── 📄 ViewController.swift
│   ├── 📄 FlightDetailsViewController.swift
│   ├── 📄 CrewViewController.swift
│   └── 📄 PassengersViewController.swift
├── 📁 Models
│   ├── 📄 Passenger.swift
│   ├── 📄 Pilot.swift
│   ├── 📄 FlightAttendant.swift
│   └── 📄 Flight.swift
├── 📁 Views
│   ├── 📄 Main.storyboard
│   └── 📄 LaunchScreen.storyboard
└── 📄 AppDelegate.swift
└── 📄 SceneDelegate.swift
```

## 🎯 Finalidade do Projeto
A finalidade deste projeto é fornecer uma ferramenta prática para o gerenciamento de voos. Ele permite:

- Adicionar Voos: Criação de novos voos especificando cidades de origem e destino, datas de ida e volta, capacidade e tripulação.
- Gerenciar Passageiros: Adicionar, visualizar e remover passageiros, garantindo que todos sejam adultos.
- Gerenciar Tripulação: Adicionar, visualizar e remover membros da tripulação, incluindo pilotos, co-pilotos e comissários de bordo.
- Visualizar Detalhes dos Voos: Exibir todas as informações relevantes sobre um voo específico, incluindo passageiros e tripulação.

## 🚀 Como Rodar
Para rodar o projeto Campeões da Copa no seu ambiente local, siga os passos abaixo:

### Clone o repositório:

```sh
git clone https://github.com/vrortega/Desafio2PDI.git
cd Desafio2PDI
```

* **Abra o Projeto no Xcode:**

Navegue até o arquivo `Desafio2PDI.xcodeproj` e abra-o com o Xcode.

* **Instale as Dependências:**

Se o projeto utilizar CocoaPods, execute `pod install` para instalar as dependências necessárias.

* **Compile e Rode o Projeto:**

Pressione `Cmd + R` ou clique no botão de rodar no Xcode.
