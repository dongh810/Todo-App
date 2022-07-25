//
//  AddTodoRequest.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/22.
//

import Foundation

struct AddTodoRequest:Encodable {
    let date: String
    let title: String
    let content: String
}
