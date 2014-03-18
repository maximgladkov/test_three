require 'spec_helper'

describe User do
  context "fully filled" do
    before(:each) do 
      @user_params = { name: 'John Doe', email: 'john@doe.com', password: 's3kr3t', password_confirmation: 's3kr3t' }
      @user = User.new @user_params
    end

    it "should require name" do
      @user.name = nil
      @user.should_not be_valid
      @user.errors.messages.should include(:name)
    end

    it "should require email" do
      @user.email = nil
      @user.should_not be_valid
      @user.errors.messages.should include(:email)
    end

    it "should require password" do
      @user.password = nil
      @user.should_not be_valid
      @user.errors.messages.should include(:password)
    end

    it "should require password_confirmation" do
      @user.password_confirmation = nil
      @user.should_not be_valid
      @user.errors.messages.should include(:password_confirmation)
    end

    it "should require password confirmation" do
      @user.password = 'other password'
      @user.should_not be_valid
      @user.errors.messages.should include(:password_confirmation)
    end

    it "should require unique email" do
      User.create(@user_params)

      @user.save
      @user.should_not be_valid
      @user.errors.messages.should include(:email)
    end

    it "should require well-formed email" do
      @user.email = 'test-email'
      @user.should_not be_valid
      @user.errors.messages.should include(:email)
    end

    describe ".encrypt_password" do
      it "should encrypt password" do
        @user.encrypt_password
        @user.encrypted_password.should_not be_nil
        @user.encrypted_password.should_not eq('s3kr3t')
      end
    end

    describe ".generate_authentication_token" do
      it "should generate authentication token before save" do
        @user.save
        @user.authentication_token.should_not be_nil
      end
    end
  end
end
