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
        static let APP_NAME: String = "GithubSwift"
        static let LOADING_TEXT: String = "Carregando . . ."
        static let OK: String = "OK"
        static let YES: String = "Sim"
        static let NO: String = "Não"
        static let REPO_NAME: String = "Repositório: "
        static let AUTHOR_NAME: String = "Autor: "
        static let EMPTY_LABEL_TEXT: String = "Sem retorno :("
        static let BAD_URL: String = "URL inválida. :("
        static let TASK_ERROR: String = "Sem conexão com a internet. Tente mais tarde!"
        static let NO_RESPONSE: String = "O servidor não encontrou os dados. Tente novamente!"
        static func INVALID_STATUS_CODE(_ code: String) -> String {
            return "Ocorreu um erro ao tentar trazer os dados. Código(\(code)"
        }
        static let NO_DATA: String = "Algo não está certo: dados inválidos."
        static let INVALID_JSON: String = "Não conseguimos ler os dados da requisição. por favor, tente mais tarde."
    }
    struct color {
        static let MAIN: UIColor = UIColor.black
        static let TITLE_LABEL: UIColor = UIColor.yellow
        static let LABEL: UIColor = UIColor.white
    }
    struct font {
        private static let defaultFamily: String = "Noto Sans Kannada"
        static let TITLE_LABEL: UIFont? = UIFont.init(name: defaultFamily, size: 18)
        static let LABEL: UIFont? = UIFont.init(name: defaultFamily, size: 14)
    }
}
