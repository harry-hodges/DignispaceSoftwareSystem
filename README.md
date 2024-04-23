# Installing

First install WSL2 on your windows laptop
Install Ubuntu for WSL
Run all of these commands in WSL2 Ubuntu (not poweshell, not command prompt, not ROS-WSL, not git-bash)

Next cd into the folder where you have cloned the repo
(if it's on the C-Drive go to /mnt/c and then the rest of the path)

## Ruby setup
```sudo apt update```


```sudo apt install ruby ruby-dev ruby-rubygems ruby-bundler```

```sudo apt install build-essential autoconf libtool pkg-config idle-python2.7   libgle3```

```sudo apt install libpq-dev```

## Database setup
```sudo apt install docker docker-compose```

```sudo systemctl enable docker```

```sudo systemctl start docker```

```sudo docker-compose up -d```

```bundle exec rails db:create```

```bundle exec rails db:migrate RAILS_ENV=development```

## Frontend setup
```cd moz-todo-react```

```sudo apt install npm```

```npm install```

```cd ..```



# Running (For developing the backend)
## Start db (Will not need to run if you just ran the set up commands)
```sudo docker-compose up -d ```


## Build frontend (only if there's a change or for the first time running)
```cd moz-todo-react```

```npm run build```

```cd ..```

## Start server
```bundle exec rails server```

## Check setup works
Go to http://127.0.0.1:3000 in the web browser and check 'Dignity Therapy' is displayed

Go to http://127.0.0.1:3000/api/test in the web browser and check 'pong' is displayed

## For developing the frontend
If you are working on the frontend it would be annoying to rebuild every time so you can run in ANOTHER TERMINAL (leaving first open)
```cd moz-todo-react```

```npm run dev```

Then you can access http://localhost:3100 to view (please check building before committing)


# Other links
You can access the database visually at
http://localhost:8080/

You can access sent emails visually at
http://localhost:8025/