# == Schema Information
#
# Table name: bubbles
#
#  id            :bigint           not null, primary key
#  name          :string
#  user_group_id :bigint
#
# Indexes
#
#  index_bubbles_on_user_group_id  (user_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_id => user_groups.id)
#
class Bubble < ApplicationRecord
    belongs_to :user_group
    
    def all_users
        users = UserBubble.where(bubble_id: self.id).map {|x| 

        User.find_by(id: x.user_id).user_details}
        users.map(&:as_json)
    end

    def users (val)
        
         UserBubble.where(bubble_id: self.id).each {|x| x.destroy}
        if (val != [""] && val != nil) 
            val.each {|x| UserBubble.create!([{bubble_id: self.id, user_id: x}])}
        end
    end
end
