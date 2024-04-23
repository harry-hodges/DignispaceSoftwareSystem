Rails.application.routes.draw do
  get '/api/:controller/', controller: /[a-zA-Z_]+/, action: "getCollection", id: /[0-9]+/
  get '/api/:controller/:id', controller: /[a-zA-Z_]+/, action: "get", id: /[0-9]+/
  post '/api/:controller', controller: /[a-zA-Z_]+/, action: "post", id: /[0-9]+/
  put '/api/:controller/:id', controller: /[a-zA-Z_]+/, action: "put", id: /[0-9]+/
  delete '/api/:controller/(:id)', controller: /[a-zA-Z_]+/, action: "delete", id: /[0-9]+/

  post '/api/potential_edits/accept/:id', controller: "potential_edits", action: "accept_potential_edit", id: /[0-9]+/
end
