require 'rails_helper'

describe InfoRequest do

	before { @info_request = InfoRequest.new(first_name: "Example", last_name: "User", email: "user@example.com",
                            message: "info") }

	subject { @info_request }

	it { should respond_to(:first_name) }
 	it { should respond_to(:last_name) }
 	it { should respond_to(:email) }
 	it { should respond_to(:message) }

  describe "when first_name is not present" do
  	before { @info_request.first_name = " " }
  	it { should_not be_valid }
  end

    describe "when last_name is not present" do
  	before { @info_request.last_name = " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @info_request.email = " " }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
   	it "should be invalid" do
   		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
       		        foo@bar_baz.com foo@bar+baz.com]
   		addresses.each do |invalid_address|
     		@info_request.email = invalid_address
     		expect(@info_request).not_to be_valid
   		end
   	end
  end

  describe "when email format is valid" do
   	it "should be valid" do
   		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
   		addresses.each do |valid_address|
     		@info_request.email = valid_address
     		expect(@info_request).to be_valid
   		end
   	end
  end

  describe "when message is not present" do
  	before { @info_request.first_name = " " }
  	it { should_not be_valid }
  end

end