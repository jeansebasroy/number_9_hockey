class UserToPlayer < ActiveRecord::Base
  	validates :user_id, numericality: { only_integer: true }
  	validates :player_id, numericality: { only_integer: true }
	
  def self.player_has_user(player_id)
   	#checks to see if Player has a valid User
  	user = UserToPlayer.where(player_id: player_id)
  	
  end

  def self.user_has_players(user_id)
   	#checks to see if Player has a valid User
  	players = UserToPlayer.where(user_id: user_id)
  	
  end


end
