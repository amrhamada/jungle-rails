require 'rails_helper'

# RSpec.describe "user-management", type: :request do
  
#   describe 'Validations' do
#     it "matched_password? should return true when both password match and login user" do 
#       # headers = { "ACCEPT" => "application/json" } 
#       get "/signup"
#       expect(response).to render_template(:new)
#       post "/signup", user:{first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11"}
#       expect(response).to redirect_to("/")
#       follow_redirect!
#       expect(response.body).to include("a@g.com")
#     end

#     it "matched_password? should render signup page when both password do not match" do 
#       get "/signup"
#       expect(response).to render_template(:new)
#       post "/signup", user:{first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada"}
#       expect(response).to render_template("users/new")
#       # puts @user.errors.any?
#       # expect(response).to redirect_to("/signup")
#       # follow_redirect!
#       # expect(response.body).to include("Password confirmation doesn't match Password")

#     end

#   end


# end


RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it "error thrown when passwords do not match" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada22")
      expect(@user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
    end
    it "user created with matching passwords" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")
      expect(@user.id).to be_present
    end
    it "throw error when email already exists" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")
      expect(@user.id).to be_present
      @user2 = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")
      expect(@user2.errors.full_messages).to eq ["Email has already been taken"]
    end
    it "throw error when email already exists with Cases different" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"A@g.com", password:"hamada11", password_confirmation:"hamada11")
      expect(@user.id).to be_present
      @user2 = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")
      expect(@user2.errors.full_messages).to eq ["Email has already been taken"]
    end
    it "fails when password is not 8 characters long" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada", password_confirmation:"hamada")
      expect(@user.errors.full_messages).to eq ["Password is too short (minimum is 8 characters)"]
      
    end
    
  end

  describe '.authenticate_with_credentials' do
    it "returns user when correct email and password are supplied" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")

      expect(User.authenticate_with_credentials("a@g.com", "hamada11")).to be_a(User)
      
    end
    it "returns nil when incorrect email supplied" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")

      expect(User.authenticate_with_credentials("ad@g.com", "hamada11")).to be(nil)
      
    end

    it "returns nil when incorrect password supplied" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")

      expect(User.authenticate_with_credentials("a@g.com", "hamada111")).to be(nil)
      
    end

    it "returns user when correct email with extra spaces in input" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")

      expect(User.authenticate_with_credentials("a@g.com ", "hamada11")).to be_a(User)
      
    end

    it "returns user when correct email with extra spaces in input and different case" do 
      @user = User.create(first_name: "Shoes", last_name:"g", email:"a@g.com", password:"hamada11", password_confirmation:"hamada11")

      expect(User.authenticate_with_credentials("A@g.com ", "hamada11")).to be_a(User)
      
    end

  end

end
