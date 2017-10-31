require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.create(:user) }

  # describe "Validations" do
  # end
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:session_token) }

  describe "Associations" do
  end

  describe "Methods" do
    describe "User#ensure_session_token" do
      it "should ensure a session token" do
        expect(user.session_token).to be_present
      end

      it "should hash a session_token" do
        allow(SecureRandom).to receive(:urlsafe_base64).and_return('token')
        # expect(user.ensure_session_token).to receive(SecureRandom::urlsafe_base64)
        expect(user.ensure_session_token).to eq('token')
      end
    end

    describe "User#reset_session_token!" do
      it "should reset session token" do
        expect(user.session_token).not_to eq(user.reset_session_token!)
      end

      it "should hash a session_token" do
        allow(SecureRandom).to receive(:urlsafe_base64).and_return('token2')
        expect(user.reset_session_token!).to eq('token2')
      end
    end

    describe "User#password=" do
      it "should set password_digest" do
        expect(user.password_digest).to be_present
      end

      it "should not save password to database" do
        User.create!(username: 'bo', password: 'passwor')
        expect(User.find_by(username: 'bo').password).to be_nil
      end

      it "should encrypt password" do
        expect(BCrypt::Password).to receive(:create)
        User.new(username: 'bobby', password: 'pastword')
      end
    end

    describe "User#is_password?" do
      it "should validate the provided password" do
        expect(BCrypt::Password.new(user.password_digest).is_password?('password')).to be true
      end
    end

    describe "User::find_by_credentials" do
      context "given valid credentials, " do
        it "should return user" do
          new_user = User.create!(username: 'boby', password: 'pasword')
          expect(User.find_by_credentials('boby', 'pasword')).to eq(new_user)
        end
      end

      context "given invalid credentials, " do
        it "should return nil" do
          User.create!(username: 'bobby', password: 'pastword')
          expect(User.find_by_credentials('bobby', 'password1234')).to be_nil
          expect(User.find_by_credentials('mary', 'password')).to be_nil
          expect(User.find_by_credentials('mary', 'asdfasdf')).to be_nil
        end
      end
    end
  end
end
