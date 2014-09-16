FactoryGirl.define do 
	factory :user do
		first_name		"Phil"
		sequence(:last_name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com"}

		#first_name		"Phil"
		#last_name		"Argyris"
		#email			"phil@example.com"
		#email 			"user_#{rand(1000).to_s}@example.com"
		password		"foobar"
		password_confirmation	"foobar"
	
		factory :admin do
			admin 		true
		end
	end

	factory :user_invitation do
		invitation_code	"12345678"
		expiration_date	"2114-09-05"
	end

	factory :user_to_player do
	end

	factory :camp do
		name 			"Test Camp"
		description		"This is a testing camp."
		publish_date	""
		age_group
	end

	factory :date_time_location do
		date 			"2014-08-08"
		start_time		"18:00"
		end_time		"19:00"
		camp
		rink
	end

	factory :rink do
		name 			"Skokie Skatium"
		address			"9300 Weber Park Place"
		city			"Skokie"
		state			"IL"
		zip_code		"60077"
	end

	factory :age_group do
		name 			"Mite"
		description		"8 or Under"
		age_start		0
		age_end			8
	end

	factory :player do
		first_name 		"Maurice"
		last_name		"Richard"
		#date_of_birth	"1921-08-04"
		date_of_birth	"2009-08-04"
		#date_of_birth	Time.now.year - 18
		shoots			"Right"
	end

	factory :player_evaluation do
		evaluation_type	"Practice"
		league			"NHL"
		team			"Canadiens"
		date 			"2008-08-08"
		player
	end

	factory :coach do
		first_name 		"Scotty"
		last_name		"Bowman"
		description		"This is a testing camp."
		publish_date	"2008-08-08"
		age_group
	end

	factory :coach_evaluation do
		name 			"Test Camp"
		description		"This is a testing camp."
		publish_date	"2008-08-08"
		coach
	end

end