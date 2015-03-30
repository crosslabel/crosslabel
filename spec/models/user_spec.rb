require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user)}
  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:auth_token)}
  it { should have_many(:upvotes)}
  it { should have_many(:authentications)}
  it { should have_one(:profile)}

  it { should validate_uniqueness_of(:auth_token)}
  it { should validate_presence_of(:email)}
  it { should validate_uniqueness_of(:email)}
  it { should validate_confirmation_of(:password)}
  it { should allow_value("example@domain.com").for(:email)}
  it { should be_valid }

    describe "before save" do
      it "make all emails lower case" do
        user = User.new(:name => "Example User", :username => "Example User", :email => "EXAMPLE@EXAMPLE.COM", :password => "foobarlala", :password_confirmation => "foobarlala")
        user.save
        expect(user.email).to eq('example@example.com')
      end
    end

    describe "email validation" do
      context "when email format is valid" do
          it "should be valid" do
            valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                            first.last@foo.jp alice+bob@baz.cn]
            valid_addresses.each do |valid_address|
                user.email = valid_address
                expect(user).to be_valid
            end
          end
      end

      context "when email format is invalid" do
          it "should not be valid" do
            invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
            invalid_addresses.each do |invalid_address|
                user.email = invalid_address
                expect(user).to_not be_valid
            end
          end
      end

      context "when user has a duplicate email that is difference case" do
          it "should not be valid" do
            duplicate_user = user.dup
            duplicate_user.email = user.email.upcase
            user.save
            expect(duplicate_user).to_not be_valid
          end
      end
    end

    describe "password validation" do
      it "should be at least 8 characters" do
         user.password = user.password_confirmation = "a"*7
         expect(user).to_not be_valid
      end
    end

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      user.generate_authentication_token!
      expect(user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      user.generate_authentication_token!
      expect(user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
