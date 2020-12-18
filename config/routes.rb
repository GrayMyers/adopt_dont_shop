Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  delete "/shelters/:id", to: "shelters#destroy"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"


  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new"
  post "/shelters/:shelter_id/pets", to: "shelter_pets#create"
  get "/shelters/:id/pets/:id", to: "pets#show"

  get "/applications/new", to: "applications#new"
  get "/applications/:id", to: "applications#show"
  patch "/applications/:id", to: "applications#update"
  post "/applications", to: "applications#create"
  post "/applications/:id", to: "applications#submit" #non restful
  get "/applications/:id/edit", to: "applications#edit"

  get "/applications/:id/pets", to: "application_pets#index"
  post "/applications/:id/pets/:pet_id", to: "application_pets#create" #non restful

  get "/admin/applications/:id", to: "admin_applications#show"
  post "/admin/applications/:id", to: "admin_applications#review" #non restful

  get "/admin/shelters", to: "admin_shelters#index"
  get "/admin/shelters/:id", to: "admin_shelters#show"
end
