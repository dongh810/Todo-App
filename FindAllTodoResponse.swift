//
//  FindAllTodoResponse.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/26.
//

import Foundation

// MARK: - FindAllTodoResponse
struct FindAllTodoResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let findedAllTodo: [FindedAllTodo]
}

// MARK: - FindedAllTodo
struct FindedAllTodo: Decodable {
    let date: String
}
