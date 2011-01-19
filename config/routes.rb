Recruitd::Application.routes.draw do
  resource :s, :only => [:manage, :home, :settings, :add_career, :add_course, :add_award, :add_interest] do
    get 'manage'
    get 'home'
    get 'browse'
    get 'settings'
    post 'add_career'
    get 'delete_career'
    post 'add_course'
    get 'delete_course'
    post 'add_award'
    get 'delete_award'
    post 'add_interest'
    get 'delete_interest'
  end
  
  resource :c, :only => [:manage, :home, :settings, :update_settings], :controller => "c" do
    get 'manage'
    get 'home'
    get 'settings'
    get 'browse'
    post 'update_settings'
  end
  
  match "s/browse/:page" => "s#browse"
  match "c/browse/:page" => "c#browse"
  
  resource :utilities do
    get 'authentications'
    get 'get_profile'
  end
  
  match "follow/:user_id" => "utilities#follow", :as => "follow"
  match "unfollow/:user_id" => "utilities#unfollow", :as => "unfollow"
  match "star/:entity_type/:entity_id" => "utilities#star", :as => "star"
  match "unstar/:entity_type/:entity_id" => "utilities#unstar", :as => "unstar"
  match "vote/:voteable_type/:voteable_id/:vote" => "utilities#vote", :as => "vote"
  
  resources :experiences


  resources :autocomplete_searches, :only => [:club_names, :course_names, :company_names, :career_names] do
    collection do
      get 'club_names'
      get 'course_names'
      get 'company_names'
      get 'career_names'
      get 'award_names'
      get 'interest_names'
    end
  end
  
  resources :jobs do
    member do
      get 'star'
      get 'dismiss'
      put 'update_file'
    end
  end
  resources :careers do
    member do
      get 'tags'
    end
  end
  resources :awards
  resources :schools
  
  resources :departments

  resources :course_students

  resources :courses do
    member do
      put 'rate'
    end
  end

  resources :clubs

  resources :rep_transactions
  resources :tasks
  resources :clubs  
  resources :job_students
  resources :company_students
  resources :updates
  resources :school_students
  resources :student_terms
  resources :experiences
  resources :term_descriptions
  resources :terms    
  resources :recruiters
  
  resources :companies do
    member do 
      put 'rate'
      get 'star'
      get 'dismiss'
      get 'update_file'
    end
  end
  
  resources :students do
    member do
      get 'star'
      get 'dismiss'
      get 'update_file'
    end
  end
  
  
  resources :categories
  
  resource :info, :controller => 'info' do
    member do
      get 'home'
      get 'updates'
    end
  end
  

  

  #devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  #root :to => ""
  authenticate :user do
    root :to => "info#home"
  end
  
  root :to => "devise/sessions#new"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
