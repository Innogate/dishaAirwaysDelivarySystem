# Endpoints

## Version
return application
```js
GET {{apiUrl}}/version
Content-Type: application/json

--- responce-expected ----
{
  "version": "0.0.1"
}
```

## Login
```js
POST {{apiUrl}}/login
Content-Type: application/json

{
    "id": "INWK00A00001",
    "passwd": "1234"
}

--- responce-expected ---
{
  "status": 200,
  "message": "Success",
  "body": {
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiSU5XSzAwQTAwMDAxIn0.kiiHSJnop6qsdep7ZoJeZTTlknMMJfKCR1lhXfZu55U"
  }
}
```