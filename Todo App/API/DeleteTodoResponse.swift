//
//  DeleteTodoResponse.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/26.
//

import Foundation

struct DeleteTodoResponse:Decodable{
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: DeleteTodo?
}
struct DeleteTodo:Decodable{
    let deletedTodo: thing
}
struct thing:Decodable{ 
    let date:String
    let title: String
    let content: String
}
