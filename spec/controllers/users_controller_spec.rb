require 'spec_helper'

describe UsersController do

  describe "POST 'authorize'" do
    it "returns http success" do
      user_params = {
        "name" => "John Doe",
        "email" => "john@doe.com", 
        "password" => "s3kr3t", 
        "password_confirmation" => "s3kr3t"
      }

      User.create user_params

      post :authorize, user_params.to_json, { :format => :json }

      response.status.should eq(200)

      response_json = JSON.parse(response.body)
      response_json['id'].should eq(1)
      response_json['name'].should eq('John Doe')
      response_json['email'].should eq('john@doe.com')
      response_json['authentication_token'].should_not be_nil
    end

    it "returns not authorized for wrong credentials" do
      user_params = {
        "name" => "John Doe",
        "email" => "john@doe.com", 
        "password" => "s3kr3t", 
        "password_confirmation" => "s3kr3t"
      }

      User.create user_params

      user_params['password'] = 'password'
      user_params['password_confirmation'] = 'password'

      post :authorize, user_params.to_json, { :format => :json }

      response.status.should eq(401)
    end

    it "returns not authorized for invalid data" do
      user_params = {
        "name" => nil,
        "email" => "john-doe-com", 
        "password" => "password", 
        "password_confirmation" => "other-password"
      }

      User.create user_params

      post :authorize, user_params.to_json, { :format => :json }

      response.status.should eq(401)
    end
  end

end
