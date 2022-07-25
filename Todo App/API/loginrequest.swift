//
//  loginrequest.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/22.
//

import Foundation

struct loginrequest:Encodable
    {
        let user_id: String
        let user_pw: String
    }

