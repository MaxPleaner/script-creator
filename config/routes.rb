Rails.application.routes.draw do
  root 'pages#root'
  post "create", to: "pages#create"
  get "script", to: "pages#script"
  get "execute", to: "pages#execute"
  get "delete", to: "pages#delete"
  get "confirm_destroy", to: "pages#confirm_destroy"
  get "clear_output", to: "pages#clear_output"
end
