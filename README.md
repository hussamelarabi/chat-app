# Instabug Challenge Chat Application using Ruby on Rails

This is a chatting application done for partial fulfilment of my application process for Instabug. This app is built using Ruby on Rails along with ElasticSearch for easy searching through messages and Sidekiq (and redis) for asynchronous handling of creation endpoints

### Requirements
    - Docker
    - Docker-compose

### To Launch The app:

   1. Clone repository
   ```bash
        git clone URL HERE
   ```
   2. Launch application 
   ```bash
        cd ChattingSystem/Docker
        docker-composer up
   ```

  3.  Services will launch on the following ports:
  - http://localhost:3001 -> Ruby on Rails Backend
  - http://localhost:3001/sidekiq -> Sidekiq Dashboard
  - http://localhost:9201 -> Elasticsearch service
  - http://localhost:6380 -> Redis Server 


  4. API documentation
| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |
 


