//
//  ddTodoResponse.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/22.
//

import Foundation

struct AddTodoResponse:Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
