//
//  Constant.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

struct Constant {
    struct string {
        static let appName: String = "GithubSwift"
        static let loadingText: String = "Carregando . . ."
        static let ok: String = "OK"
        static let yes: String = "Sim"
        static let no: String = "Não"
        static let repoName: String = "Repositório: "
        static let authorName: String = "Autor: "
        static let emptyLabelText: String = "Sem retorno :("
        static let badURL: String = "URL inválida. :("
        static let taskError: String = "Sem conexão com a internet. Tente mais tarde!"
        static let noResponse: String = "O servidor não encontrou os dados. Tente novamente!"
        static func invalidStatusCode(_ code: String) -> String {
            return "Ocorreu um erro ao tentar trazer os dados. Código(\(code))"
        }
        static let noData: String = "Algo não está certo: dados inválidos."
        static let invalidJson: String = "Não conseguimos ler os dados da requisição. por favor, tente mais tarde."
        static let errorDetailPresent: String = "Não foi possível abrir os detalhes do repositório!"
    }
    
    struct color {
        static let main: UIColor = UIColor.black
        static let clean: UIColor = UIColor.clear
        static let backgroundColorWithAlpha: UIColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.3)
        static let backgroundColorDarkWithAlpha: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        static let titleLabel: UIColor = UIColor.white
        static let starColor: UIColor = UIColor.yellow
        static let label: UIColor = UIColor.white
        static let orange: UIColor = UIColor.systemOrange
    }
    
    struct font {
        private static let defaultFamily: String = "NotoSansKannada"
        static let titleLabel: UIFont? = UIFont.init(name: defaultFamily + "-Bold", size: 18)
        static let descriptionLabel: UIFont? = UIFont.init(name: defaultFamily, size: 17)
        static let label: UIFont? = UIFont.init(name: defaultFamily, size: 14)
    }
    
    struct image {
        static let placeholder: UIImage? = UIImage(named: "placeholder")
        static let cat: UIImage? = UIImage(named: "cat")
        static let star: UIImage? = UIImage(named: "star")
    }
    
    struct distance {
        struct horizontal {
            static let extraSmall: CGFloat = 5
            static let small: CGFloat = 8
            static let normal: CGFloat = 15
            static let big: CGFloat = 30
        }
        
        struct vertical {
            static let small: CGFloat = 5
            static let normal: CGFloat = 8
            static let big: CGFloat = 20
        }
        
        static let zero: CGFloat = 0
    }
}
