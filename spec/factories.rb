FactoryGirl.define do 
	factory :user do
		first_name	"Phil"
		last_name	"Argryris"
		email		"phil@example.com"
		password	"foobar"
		password_confirmation	"foobar"
	end
end