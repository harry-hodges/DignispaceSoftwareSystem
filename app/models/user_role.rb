# == Schema Information
#
# Table name: user_roles
#
#  id            :bigint           not null, primary key
#  role          :string
#  user_group_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_user_roles_on_user_group_id  (user_group_id)
#  index_user_roles_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_id => user_groups.id)
#  fk_rails_...  (user_id => users.id)
#
class UserRole < ApplicationRecord
    belongs_to :user
    belongs_to :user_group, class_name: 'UserGroup', foreign_key: :user_group_id
    
    def get_group
        UserGroup.find_by(id: user_group_id)
    end

    def get_user 
        User.find_by(id: user_id)&.user_details
    end
end
  
