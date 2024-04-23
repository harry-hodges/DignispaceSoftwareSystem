# Specification Swagger Document
Make a request to 

```
https://api.getpostman.com/collections/24270782-075812a7-7695-41fa-a33b-287d9e904b32/transformations
```

With X-API-Key being your postman API key (talk to Will if unsure)

Save the result to  ```spec.json```

Then run
```
sed -e 's/\\n/\
/g' -e 's/\\"/"/g' spec.json > public/docs/spec.json
```

# Deploying to own server (epigenesis, why are the demo servers auth protected, just put it behind the VPN)
Hosting a version of the project on my own server to avoid random restriction

Docs at:

https://dignispace.test.willjay.rocks/docs

DB access at:

https://dignispace-adminer.test.willjay.rocks/


## Commands
Copy files to server

```
cp -r ~/Documents/Docs/_Files/COM3420/cleanProject/project/* jillpi@stuff.willjay.rocks:~/Documents/rails
```

Start docker containers
```
sudo docker compose up -d
```

Caddy.json
```
```

Start server
```
RAILS_ENV=production rails server
```