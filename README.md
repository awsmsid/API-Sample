# README

Welcome to mivi! This is the main API for mivi application.

* Ruby version

    This application using ruby 2.5.0 and running on rails 5.1.4

* System dependencies

* Configuration

* Database creation

    ```rake db:create```

* Database initialization

    ```rake db:migrate```

* How to run the test suite

    In order to run the test you can default reke task
    
    ```rake```

* Services (job queues, cache servers, search engines, etc.)

    In order to processing queue to be started, you need to run this command :
    
    ```bundle exec dotenv shoryuken -R -C config/shoryuken.yml```
    
    on server configuration you can remove the dotenv

* Deployment instructions

* Run Cucumber test
  
    With Rake :
  
    ```rake cucumber```

    Without Rake:

    ```[bundle exec] cucumber```
    