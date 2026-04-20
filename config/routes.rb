Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :alunos, only: [:create] #POST /alunos
  resources :usuarios, only: [:create] #POST /usuarios
  resources :disciplinas, only: [:index, :create, :update, :destroy]
  resources :professores, only: [:index, :create, :update, :destroy]
  resources :semestres, only: [:index, :create, :update, :destroy]

  post 'login', to: 'sessions#create' # POST /login - endpoint de login
  post 'coordenacao/importar_turmas_csv', to: 'coordenacao#importar_turmas_csv'
  
  #Isso cria as rotas REST:
  #GET /professores
  #GET /professores/:id
  #POST /professores
  #PUT /professores/:id
  #PATCH /professores/:id
  #DELETE /professores/:id
  #resources :professores

end