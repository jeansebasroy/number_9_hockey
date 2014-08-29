FactoryGirl.define do 
	factory :user do
		first_name	"Phil"
		last_name	"Argryris"
		email		"phil@example.com"
		password	"foobar"
		password_confirmation	"foobar"
	
		factory :admin do
			admin true
		end
	end

	factory :age_group do
		name 		"Mite"
		description	"8 or Under"
		age_start	0
		age_end		8
	end

	factory :camp do
		name 			"Test Camp"
		description		"This is a testing camp."
		publish_date	"2014-08-08"
		age_group		"Mite"
	end

end