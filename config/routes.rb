Rails.application.routes.draw do
  # resources :courses
  # resources :awards
  # resources :students
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :courses do 
    member do
      get :roll 
    end 
  end
     
  resources :students do 
    resources :awards
     member do 
       get  :courses 
       post :course_add 
       post :course_remove 
     end 
   end
   
end
