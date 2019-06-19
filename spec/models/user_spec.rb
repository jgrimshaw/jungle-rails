require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new firstname: "first", lastname: "last", email: "test@example.com", password: "hello", password_confirmation: "hello"
    @user2 = User.new firstname: "first", lastname: "last", email: "Test@example.com", password: "hello", password_confirmation: "hello"
  end

  describe "Signup Validations" do

    it "if everything is valid adds user to database" do
      expect(@user.valid?).to be_truthy
    end

    it "if no firstname not valid" do
      @user.firstname = nil
      @user.save
      expect(@user.errors.full_messages).to include "Firstname can't be blank"
    end

    it "if no lastname not valid" do
      @user.lastname = nil
      @user.save
      expect(@user.errors.full_messages).to include "Lastname can't be blank"
    end

    it "if no email not valid" do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it "if no password not valid" do
      @user = User.new firstname: "first", lastname: "last", email: "test@example.com", password_confirmation: "hello"
      @user.save
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it "if no password_confirmation not valid" do
      @user = User.new firstname: "first", lastname: "last", email: "test@example.com", password: "hello", password_confirmation: ""
      @user.save
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it "if email already exists not valid" do
      @user.save
      @user2.save
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end

    it "if password is shorter than 3 not valid" do
      @user3 = User.new firstname: "first", lastname: "last", email: "test@example.com", password: "mm", password_confirmation: "mm"
      @user3.save
      expect(@user3.errors.full_messages).to include "Password is to short"
    end
  end

  describe '.authenticate_with_credentials' do

    it "if user logs in without previous credentials" do
      @user.save
      @user_login = User.authenticate_with_credentials('first@gmail.com', 'ello')
      expect(@user_login).to be_nil
    end

    it "if incorrect password" do
      @user.save
      @user_login = User.authenticate_with_credentials('test@example.com', ' ddddgjskello')
      expect(@user_login).to be_nil
    end

    it "all credetials are correct" do
      @user.save
      @user_login = User.authenticate_with_credentials('test@example.com', 'hello')
      expect(@user_login).to be_truthy
    end

    it "all credetials are correct but excess spaces" do
      @user.save
      @user_login = User.authenticate_with_credentials('  test@example.com  ', 'hello')
      expect(@user_login).to be_truthy
    end

    it "all credetials are correct but excess spaces" do
      @user.save
      @user_login = User.authenticate_with_credentials('   test@example.com   ', 'hello')
      expect(@user_login).to be_truthy
    end

    it "all credetials are correct but capitals letters" do
      @user.save
      @user_login = User.authenticate_with_credentials('teSt@example.com', 'hello')
      expect(@user_login).to be_truthy
    end
  end
end