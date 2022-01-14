# Instabug Challenge Chat Application using Ruby on Rails

This is a chatting application done for partial fulfilment of my application process for Instabug. This app is built using Ruby on Rails along with ElasticSearch for easy searching through messages and Sidekiq (and redis) for asynchronous handling of creation endpoints

### Prerequisites
    - Docker
    - Docker-compose

### High-level system architecture:
![high level system architecture](https://github.com/hussamelarabi/chat-app/blob/master/system%20design.drawio.png)

### To Launch The app:

   1. Clone repository
   ```bash
        git clone https://github.com/hussamelarabi/chat-app.git
   ```
   2. Launch application 
   ```bash
        cd chat_app/Docker
        docker-compose up
   ```

  3.  Services will launch on the following ports:
  - http://localhost:3001 -> Ruby on Rails Backend
  - http://localhost:3001/sidekiq -> Sidekiq Dashboard
  - http://localhost:9201 -> Elasticsearch service
  - http://localhost:6380 -> Redis Server 

  4. Sample Runs

  - POST localhost:3001/applications/create_app?name=apptest
  ```json
     {
        "response": "App creation request added"
     }
```
STATUS RESPONSE: 202 Created
- POST localhost:3001/applications/:token/create_chat
```json
     {
        "response": "Chat creation request added"
     }
```
STATUS RESPONSE: 202 Created

- POST localhost:3001/applications/:token/chats/:chat_number/send_message?body=test_body
```json
     {
        "response": "Message creation request added"
     }
```
STATUS RESPONSE: 202 Created
- GET localhost:3001/applications/:token/chats/:chat_number/get_messages
```json
{
    "response": "ok",
    "messages": [
        {
            "message_number": 1,
            "body": "test_body",
            "created_at": "2022-01-14T15:06:49.000Z"
        }
    ]
}
```
STATUS RESPONSE: 200 OK

### API Documentation

- Application endpoints [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/19134366-c312117e-465c-4fbe-aab6-4297dd3de539?action=collection%2Ffork&collection-url=entityId%3D19134366-c312117e-465c-4fbe-aab6-4297dd3de539%26entityType%3Dcollection%26workspaceId%3Dbf66c651-a6bd-47a8-9717-dc4ed146e6a4)


- Chat endpoints [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/19134366-77efc3a5-cfc8-4648-8774-042a8194a1f5?action=collection%2Ffork&collection-url=entityId%3D19134366-77efc3a5-cfc8-4648-8774-042a8194a1f5%26entityType%3Dcollection%26workspaceId%3Dbf66c651-a6bd-47a8-9717-dc4ed146e6a4)

- Message endpoints [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/19134366-e5c94e27-63e6-476c-83cf-c6b8c09672f4?action=collection%2Ffork&collection-url=entityId%3D19134366-e5c94e27-63e6-476c-83cf-c6b8c09672f4%26entityType%3Dcollection%26workspaceId%3Dbf66c651-a6bd-47a8-9717-dc4ed146e6a4)
