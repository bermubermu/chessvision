SampleApp::Application.routes.draw do
	resources :sessions, :only => [:new, :create, :destroy]
	resources :books
	resources :clubs
	resources :tournaments
	resources :battles
	resources :users
	resources :microposts
	resources :posts
	resources :notices
	resources :requests
	resources :alloweds
	resources :players

	match '/event',  :to => 'books#event'
	match '/site',  :to => 'books#site'
	match '/date',  :to => 'books#date'
	match '/searchall',  :to => 'books#searchall'
	match '/search',  :to => 'books#search'

	match '/board',  :to => 'clubs#board'
	match '/requestt',  :to => 'clubs#requestt'
	match '/friends',  :to => 'clubs#friends'
	match '/news',  :to => 'clubs#news'

	match '/participants',  :to => 'tournaments#participants'
	match '/versus',  :to => 'tournaments#versus'
	match '/classification',  :to => 'tournaments#classification'

	match '/signup',  :to => 'users#new'
	match '/signin',  :to => 'sessions#new'
	match '/signout', :to => 'sessions#destroy'

	match '/man',    :to => 'pages#man'
	match '/elo',    :to => 'pages#elo'
	match '/tablero',    :to => 'pages#tablero'
	match '/ia',    :to => 'pages#ia'
	match '/forgot',    :to => 'users#forgot'


	root :to => 'pages#home'
	match '/english',    :to => 'pages#home2'
end
