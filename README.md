# **Restoran Si Gigih**

Restoran Si Gigih is a Backend Project for help Gigih Family management data of they restaurant.

## Documentation
  - ## Category
      - ### Create Category
          - #### **POST** /categories
            - Request Body Example
               ```javascript
                {
                  "name": "Masakan Padang"  //required
                }
               ```
            - Response Example
              ```javascript
                {
                  "status": "created",
                  "message": "Berhasil menambahkan kategori",
                  "data": {
                  "categoryId": 73
                   }
                }
               ```
       - ### Get All Categories
           - #### **GET** /categories
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "data": {
                  "categories": [
                       {
                          "id": 72,
                          "name": "Masakan padang"
                        },
                        {
                           "id": 73,
                           "name": "Masakan Bali"
                        }
                     ]
                  }
                }
               ```
       - ### Get Detail Category
           - #### **GET** /categories/{id}
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "data": {
                  "category": {
                        "id": 73,
                        "name": "Masakan Bali"
                      }
                  }
                }
               ```
       - ### Update Category
           - #### **PUT** /categories/{id}
             - Request Body Example
               ```javascript
                {
                  "name": "Masakan Lombok"  //required
                }
               ```
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "message": "Berhasil memperbarui kategori",
                  "data": {
                  "categoryId": 74
                   }
                }
               ```
       - ### Delete Category
           - #### **DELETE** /categories/{id}
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "message": "Kategori berhasil dihapus"
                }
               ```
  - ## Food
       - ### Create Food
          - #### **POST** /foods
            - Request Body Example
               ```javascript
                {
                  "name": "Sate Padang",
                  "price": "10000",
                  "description": "Makanan kesukaan Rara",
                  "categories": [
                     { 
                        "id": 7
                     }
                  ]
                }
               ```
            - Response Example
              ```javascript
                {
                   "status": "success",
                   "message": "Makanan telah berhasil ditambahkan",
                   "data": {
                      "foodId": 47
                     }
                 }
               ```
       - ### Get All Foods
           - #### **GET** /foods
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "data": {
                  "categories": [
                       {
                          "id": 72,
                          "name": "Masakan padang"
                        },
                        {
                           "id": 73,
                           "name": "Masakan Bali"
                        }
                     ]
                  }
                }
               ```
       - ### Get Detail Food
           - #### **GET** /foods/{id}
             - Response Example
               ```javascript
                    {
                      "status": "success",
                      "data": {
                        "food": {
                            "id": 49,
                            "name": "Sate Padang",
                            "price": 10000.0,
                            "description": "Sate Padang adalah makanan kesukaan rara",
                            "categories": [
                                  {
                                      "name": "Masakan Bali"
                                  }
                                ]
                              }
                            }
                          }
               ```
       - ### Update Food
           - #### **PUT** /foods/{id}
             - Request Body Example
               ```javascript
                {
                  "name": "Pelecing",
                  "price": "5000",
                  "description": "Makanan khas Lombok",
                  "categories": [
                     { 
                        "id": 8
                     }
                  ]
                }
               ```
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "message": "Berhasil memperbarui kategori",
                  "data": {
                  "categoryId": 74
                   }
                }
               ```
       - ### Delete Food
           - #### **DELETE** /foods/{id}
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "message": "Berhasil menghapus data makanan"
                }
               ```
  - ## Order
       - ### Create Order
          - #### **POST** /orders
            - Request Body Example
               ```javascript
                {
                  "email": "examine@gmail.com",
                  "orders": [
                    {"foodId": 1, "qty": 2},
                    {"foodId": 2, "qty": 3}
                   ]
                }
               ```
            - Response Example
              ```javascript
                {
                   "status": "success",
                   "message": "Pesanan berhasil ditambahkan",
                   "data": {
                      "orderId": 47
                     }
                 }
               ```
       - ### Get All Orders
           - #### **GET** /orders
             - Response Example
               ```javascript
                    {
                        "status": "success",
                        "data": {
                        "orders": [
                            {
                                "id": 29,
                                "email": "examine88@gmail.com",
                                "date": "22/04/2022",
                                "status": "new",
                                "foods": [
                                  {
                                    "name": "Sate Padang",
                                    "price": 10000.0,
                                    "qty": 2
                                  },
                                  {
                                    "name": "Pelecing",
                                    "price": 5000.0,
                                    "qty": 3
                                  }
                              ],
                        "total": 35000.0
                        }
                    ]
                  }
                }
               ```
       - ### Get All History Order by Date Now
           - #### **GET** /orders
             - Response Example
               ```javascript
                    {
                        "status": "success",
                        "data": {
                        "orders": [
                            {
                                "id": 29,
                                "email": "examine88@gmail.com",
                                "date": "22/04/2022",
                                "status": "new",
                                "foods": [
                                  {
                                    "name": "Sate Padang",
                                    "price": 10000.0,
                                    "qty": 2
                                  },
                                  {
                                    "name": "Pelecing",
                                    "price": 5000.0,
                                    "qty": 3
                                  }
                              ],
                        "total": 35000.0
                        }
                    ]
                  }
                }
               ```
       - ### Get Detail Order
           - #### **GET** /orders/{id}
             - Response Example
               ```javascript
                    {
                        "status": "success",
                        "data": {
                        "order": 
                            {
                                "id": 29,
                                "email": "examine88@gmail.com",
                                "date": "22/04/2022",
                                "status": "new",
                                "foods": [
                                  {
                                    "name": "Sate Padang",
                                    "price": 10000.0,
                                    "qty": 2
                                  },
                                  {
                                    "name": "Pelecing",
                                    "price": 5000.0,
                                    "qty": 3
                                  }
                              ],
                        "total": 35000.0
                        }
                    }
                  }
               ```
       - ### Update Order
           - #### **PUT** /orders/{id}
             - Request Body Example
               ```javascript
                {
                  "email": "naufalazmi@gmail.com",
                  "orders": [
                    {"foodId": 2, "qty": 3}
                   ]
                }
               ```
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "message": "Data pesanan telah berhasil diubah"
                }
               ```
       - ### Update Order Status Paid
           - #### **PUT** /orders/{id}/paid
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "message": "Pesanan berhasil di bayar"
                }
               ```
       - ### Delete Food
           - #### **DELETE** /orders/{id}
             - Response Example
               ```javascript
                {
                  "status": "success",
                  "message": "Pesanan berhasil dihapus"
                }
               ```
