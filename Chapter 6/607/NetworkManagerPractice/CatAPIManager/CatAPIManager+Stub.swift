//
//  CatAPIManager+Stub.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

extension CatAPIManager.Endpoint {
    var stub: Data {
        let string: String
        switch self {
            case .images:
                string = """
[
{
"id": "1co",
"url": "https://cdn2.thecatapi.com/images/1co.png",
"width": 768,
"height": 1024
},
{
"id": "1no",
"url": "https://cdn2.thecatapi.com/images/1no.jpg",
"width": 500,
"height": 333
},
{
"id": "4gj",
"url": "https://cdn2.thecatapi.com/images/4gj.gif",
"width": 500,
"height": 287
},
{
"id": "a71",
"url": "https://cdn2.thecatapi.com/images/a71.jpg",
"width": 560,
"height": 732
},
{
"id": "b2r",
"url": "https://cdn2.thecatapi.com/images/b2r.png",
"width": 426,
"height": 640
},
{
"id": "MTUzNDkzMw",
"url": "https://cdn2.thecatapi.com/images/MTUzNDkzMw.jpg",
"width": 625,
"height": 469
},
{
"id": "MTc1NTM2OQ",
"url": "https://cdn2.thecatapi.com/images/MTc1NTM2OQ.gif",
"width": 350,
"height": 146
},
{
"id": "MTk3ODQ2NQ",
"url": "https://cdn2.thecatapi.com/images/MTk3ODQ2NQ.jpg",
"width": 640,
"height": 487
},
{
"id": "yFwzO96ds",
"url": "https://cdn2.thecatapi.com/images/yFwzO96ds.jpg",
"width": 1200,
"height": 776
},
{
"id": "0Vz3XgaPM",
"url": "https://cdn2.thecatapi.com/images/0Vz3XgaPM.jpg",
"width": 1600,
"height": 1065
}
]
"""
            case .addToFavorite:
                string = """
{
    "id":100038507
}
"""
            case .favorites:
                string = """
[{
"id":100038507,
"image_id":"E8dL1Pqpz",
"sub_id":null,
"created_at":"2022-07-10T12:24:39.000Z",
"image":{
    "id":"E8dL1Pqpz",
    "url":"https://cdn2.thecatapi.com/images/E8dL1Pqpz.jpg"
    }
}]
"""
            case .removeFromFavorite:
                string = ""
        }
        
        return Data(string.utf8)
    }
}
