require 'spec_helper'


describe User do

  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com", :password => "password123", :password_confirmation =>"password123"}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

   it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
   end

	
   it "should require a email" do
    no_name_user = User.new(@attr.merge(:email => ""))
    no_name_user.should_not be_valid
   end
 
 	
   it "should reject name if it is too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
   end
 
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

   it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
   end
   
   it "it should be key sensitive" do
    # Put a user with given email address into the database.
    upcase_email = @attr[:email].upcase
	User.create!(@attr)
    user_with_duplicate_email = User.new(@attr.merge(:email => upcase_email))
    user_with_duplicate_email.should_not be_valid
   end

   it "should not be blank" do
    no_pass_user = User.new(@attr.merge(:password => "" , :password_confirmation => ""))
    no_pass_user.should_not be_valid
   end
   
   it "conf pass shuold be the same" do
    wrong_pass_user = User.new(@attr.merge(:password_confirmation=> "neujemajoca"))
    wrong_pass_user.should_not be_valid
   end
    
   it "pass should not be to long" do
    long = "a"*40
    long_pass_user = User.new(@attr.merge(:password => long,:password_confirmation => long))
    long_pass_user.should_not be_valid
   end
  
  it "pass should not be to short" do
    short = "b"*5
    short_pass_user = User.new(@attr.merge(:password=> short,:password_confirmation=> short))
    short_pass_user.should_not be_valid
   end   
   
   describe "PASSWORD ENCRYPTION" do
	   
		before(:each) do
		  @user = User.create!(@attr)
		end

	    it "should have an encrypted password attribute" do
		  @user.should respond_to(:encrypted_password)
		end
		 
		 it "should set the encrypted password" do
		@user.encrypted_password.should_not be_blank
		end

    
   
	   describe "has_password? method" do

		  it "should be true if the passwords match" do
			@user.has_password?(@attr[:password]).should be_true
		  end    

		  it "should be false if the passwords don't match" do
			@user.has_password?("invalid").should be_false
		  end 

	   end
	   
	   
	   describe "authenticise" do

		  it "should be true if user JE avtentiziran" do
			good_user = @user.authenticate(@attr[:email],@attr[:encrypted_password])
		    good_user == @user
		end    

		  it "should be true if user NI avtentiziran" do
			wrong_user = @user.authenticate("invakllid","invaljgid")
		    wrong_user.should be_nil
		  end 

	   end
   end 
end
