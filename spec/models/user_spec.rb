require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "is valid with matching password and confirmation" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'john@example.com'
      user.save

      user.password = 'password123'
      user.save

      user.password_confirmation = 'password123'
      user.save

      expect(user).to be_valid
    end

    it "is invalid when password and confirmation do not match" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'john@example.com'
      user.save

      user.password = 'password123'
      user.save

      user.password_confirmation = 'differentpassword'
      user.save

      expect(user.password).not_to eql(user.password_confirmation)
    end

    it "is invalid without a password" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'john@example.com'
      user.save

      user.password = nil
      user.save

      user.password_confirmation = nil
      user.save

      expect(user).not_to be_valid
    end

    it "is invalid if email is not unique" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'john@example.com'
      user.save

      user.password = 'password123'
      user.save

      user.password_confirmation = 'password123'
      user.save

      user2 = User.new(first_name: 'Jane')
      user2.last_name = 'Smith'
      user2.email = 'john@example.com'

      expect(user2).not_to be_valid
    end

    it "is invalid without a first name, last name, and email" do
      user = User.new(first_name: nil)
      user.last_name = nil
      user.email = nil

      expect(user).not_to be_valid
    end

    it "is invalid with a password less than 6 characters" do
      user = User.new(first_name: 'Jane')
      user.last_name = 'Smith'
      user.email = 'jane@example.com'
      user.password = '12345'

      expect(user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "logs in a user with correct credentials" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'john@example.com'
      user.password = 'password123'
      user.password_confirmation = 'password123'
      user.save

      expect(User.authenticate_with_credentials('john@example.com', 'password123')).to be_truthy
    end

    it "does not log in a user with incorrect credentials" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'john@example.com'
      user.password = 'password123'
      user.password_confirmation = 'password123'
      user.save

      expect(User.authenticate_with_credentials('test@example.com', 'wrongpassword')).to be_falsy
    end

    it "logs in a user with mixed case email in the database and lowercase login email" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'JoHn@example.com'
      user.password = 'password123'
      user.password_confirmation = 'password123'
      user.save

      expect(User.authenticate_with_credentials('john@example.com', 'password123')).to be_truthy
    end

    it "logs in a user with mixed case email in the database and mixed case login email" do
      user = User.new(first_name: 'John')
      user.last_name = 'Doe'
      user.email = 'JoHn@example.com'
      user.password = 'password123'
      user.password_confirmation = 'password123'
      user.save

      expect(User.authenticate_with_credentials('JoHn@example.com', 'password123')).to be_truthy
    end
  end
end