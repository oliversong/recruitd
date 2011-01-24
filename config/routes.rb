Recruitd::Application.routes.draw do
  # constraints(:subdomain => "hiring") do
  #   match "/" => "hiring#home", 
  # end
  
  # match '/' => 'hiring#home', :constraints => { :subdomain => "hiring" }  
  
  resource :s, :only => [:add_term, :delete_term, :update_file] do
    # get 'manage'
    # get 'home'
    # get 'browse'
    # get 'settings'
    get 'add_term'
    get 'delete_term'
    post 'update_file'
  end
  
  resource :c, :only => [:manage, :home, :settings, :update_settings], :controller => "c" do
    # get 'manage'
    # get 'home'
    # get 'settings'
    # get 'browse'
    post 'update_settings'
    post 'highlight'
    post 'unhighlight'
  end
  
  match "s/browse/:page" => "s#browse"
  match "c/browse/:page" => "c#browse"
  
  resource :utilities, :only => [:import_linkedin_profile] do
    get 'authentications'
    get 'import_linkedin_profile'
    post 'apply_label'
    post 'create_label'
    post 'add_term'
  end
  
  match "follow/:user_id" => "utilities#follow", :as => "follow"
  match "unfollow/:user_id" => "utilities#unfollow", :as => "unfollow"
  match "star/:entity_type/:entity_id" => "utilities#star", :as => "star"
  match "unstar/:entity_type/:entity_id" => "utilities#unstar", :as => "unstar"
  match "vote/:entity_type/:entity_id/:vote" => "utilities#vote", :as => "vote"
  match "rate/:entity_type/:entity_id/:rating" => "utilities#rate", :as => "rate"
  
  resources :experiences

  match "autocomplete_searches/term_names/:type" => "autocomplete_searches#term_names", :as => "autocomplete"

  # resources :autocomplete_searches, :only => [:club_names, :course_names, :company_names, :career_names, :skill_names] do
  #   collection do
  #     get 'club_names'
  #     get 'course_names'
  #     get 'company_names'
  #     get 'career_names'
  #     get 'award_names'
  #     get 'skill_names'
  #     get 'interest_names'
  #     get 'all_term_names'
  #   end
  # end
  
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
      get 'test'
    end
    collection do
      get 'build'
    end
  end
  
  resources :authentications, :only => [:from_linkedin, :from_facebook] do
    collection do
      get 'newly_created'
      get 'from_linkedin'
      get 'from_facebook'
      post 'finalize_linkedin'
      post 'finalize_facebook'
    end
  end
  
  resources :categories
  
  resource :info, :controller => 'info' do
    member do
      get 'home'
      get 'manage'
      get 'settings'
      get 'browse'
      get 'updates'
      get 'public'
    end
  end

  match "home" => "info#home", :as => "home"
  match "public" => "info#public", :as => "public"
  match "manage" => "info#manage", :as => "manage"
  match "browse" => "info#browse", :as => "browse"
  match "settings" => "info#settings", :as => "settings"

  
  resources :feedbacks, :only => [:create, :new]

  #devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", 
            :registrations => "registrations"}
  
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
  # authenticate :user do
  #   root :to => "info#home"
  # end

  
  root :to => "info#home", 
  #root :to => "devise/sessions#new"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
