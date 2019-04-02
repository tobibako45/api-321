# README

### Web APIを作ろう！(codebaseイベント 2019.3.21 )

一覧
```
curl -X GET http://localhost:3000/users -H 'Content-Type: application/json'
```

登録
```
curl -X POST http://localhost:3000/users -H 'Content-Type: application/json' -d '{"name": "user1","description": "user1のdescription", "email": "user1@example.com","password": "password"}'
```

詳細
```
curl -X GET http://localhost:3000/users/1 -H 'Content-Type: application/json'
```

ログイン [検証のため、有効期限を１分に設定してる]
```
curl -X POST http://localhost:3000/users/login -H 'Content-Type: application/json' -d '{"email": "user1@example.com","password": "password"}'
```



自分のタスクの作成  
```
curl -F title=たすく -F description=テスト説明 -F status=0 http://localhost:3000/todos -H 'Authorization: Token eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InVzZXIxQGV4YW1wbGUuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.a0U7auslNuYr8qsE_zCrhEThc1ksLbfOMz5DiM9qcsg'
```

自分のタスク一覧
  
```
curl -X GET http://localhost:3000/todos -H 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InVzZXIxQGV4YW1wbGUuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.a0U7auslNuYr8qsE_zCrhEThc1ksLbfOMz5DiM9qcsg' -H 'Content-Type: application/json'
```

自分のタスク詳細
```
curl -X GET http://localhost:3000/todos/1 -H 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InVzZXIxQGV4YW1wbGUuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.a0U7auslNuYr8qsE_zCrhEThc1ksLbfOMz5DiM9qcsg' -H 'Content-Type: application/json'
```

自分のタスクの更新  
```
curl -X PATCH http://localhost:3000/todos/1 -H 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InVzZXIxQGV4YW1wbGUuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.a0U7auslNuYr8qsE_zCrhEThc1ksLbfOMz5DiM9qcsg' -H 'Content-Type: application/json'  -d '{"title": "タイトル変えたよ","description": "description変えたよ", "status": 1}'
```

自分のタスクの削除 
```
curl -X DELETE http://localhost:3000/todos/1 -H 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InVzZXIxQGV4YW1wbGUuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.a0U7auslNuYr8qsE_zCrhEThc1ksLbfOMz5DiM9qcsg' -H 'Content-Type: application/json'
```

