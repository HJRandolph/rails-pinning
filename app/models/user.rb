class User < ActiveRecord::Base
has_secure_password

has_many :pinnings
has_many :pins, through: :pinnings
has_many :boards
has_many :followers


	validates_presence_of :first_name, :last_name, :email, :password
	validates_uniqueness_of :email

	def self.authenticate(email, password)
    	@user = User.find_by_email(email)
    		if !@user.nil?
			  if @user.authenticate(password)
            return @user
        		end
 			end
    	return nil
	end
	
	def full_name
		first_name + " " + last_name.capitalize
	end
	
	def followed
		Follower.where("follower_id=?", self.id).map{|f| f.user }
	end
	
	def not_followed
		User.all - self.followed - [self]
	end
	
	def user_followers
		self.followers.map {|f| User.find(f.follower_id)}
	end
	
	
###################### the last end	######################
end
