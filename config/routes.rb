Rails.application.routes.draw do

  get '/', to: 'pages#root'
  get 'pages/root', to: "pages#root", as: :root
  
  # scripts
    post "create", to: "pages#create"
    get "script", to: "pages#script"
    get "execute", to: "pages#execute"
    get "delete", to: "pages#delete"
    get "confirm_destroy", to: "pages#confirm_destroy"
    get "clear_output", to: "pages#clear_output"

  # pages
    post "save_html_page", to: "pages#save_html_page"
    delete "delete_html_page", to: "pages#delete_html_page"
    get "html_page", to: "pages#html_page"
end
