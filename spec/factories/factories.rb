FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "coder#{n}@skillcrush.com" }
		first_name "Skillcrush"
		last_name "Coder"
		password "secret"
		
		factory :user_with_boards do
			after(:create) do |user|
				create_list(:pin,3)
				user.boards << FactoryGirl.create(:board)
				3.times do
					user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
				end
			end
		end
		
		factory :user_with_followees do
			after(:create) do |user|
				3.times do
			    	Follower.create(user: FactoryGirl.create(:user), follower_id: user.id)
				end
			end
		end
	end
	
	
	factory :board do
		name "My pins!"
	end
	
	factory :pinning do
		pin
		user
	end
	
	factory :category do
		name "rails"
	end
	
	sequence :slug do |n|
		"slug#{n}"
	end
	
	factory :pin do
		title "Rails Cheatsheet"
		url "http://rails-cheat.com"
		text "A great tool for beginning developers"
		slug
		category
	end
	
	
	
end