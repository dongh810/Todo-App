//
//  FindTodoResponse.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/23.
//

import Foundation

struct FindTodoResponse:Decodable{
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: find?
}
struct find:Decodable{
    let findedTodo: [object]
}
struct object:Decodable{
    var id : String
    var date: String
    var title: String
    var content :String
}
//선택된 날짜 있어야됨
//선택된 날짜 변수를 만들어서 밖에서는 오늘날짜를 만ㄷ르어 주는데 사용
//선택된
