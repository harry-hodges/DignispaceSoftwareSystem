# == Schema Information
#
# Table name: user_groups
#
#  id               :bigint           not null, primary key
#  content_released :boolean
#  image            :string
#  name             :string
#
class UserGroup < ApplicationRecord
   has_many :user_role

   def roles
      UserRole.where(user_group_id: id)
   end

   def as_json(options = {})   
      super(options.merge(include: {
         roles: {methods: :get_user}
      }))
   end
  
end
  
