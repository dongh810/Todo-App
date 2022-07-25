//
//  EnrollRequest.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/22.
//

import Foundation

struct EnrollRequest: Encodable{
    let user_id: String
    let user_pw: String
    let user_confirmPw: String
    let user_name: String
}
