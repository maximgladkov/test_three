Test3::Application.routes.draw do
  
  post '/users/authorize' => 'users#authorize', as: :authorize_user

end
