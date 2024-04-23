# frozen_string_literal: true

class Ability
  # Alert: DONE
  # Answer: 
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/hash_of_conditions.md

    return unless user.present? # User login required to access the resource
    # Definitions for normal operation (read/write questions, healthcare professional e.c.t.)

    # ALERT: DONE
    # ANSWER: DONE_ISH
    # AUDIT LOG: NOT NEEDED
    # FLAG: DONE
    # POTENTIAL EDIT: DONE
    # PREFERENCE: DONE
    # QUESTIONS: NOT NEEDED

    can :manage, Alert, user: user

    can :create, EmotionalSupportRequest
    
    # USER GROUP / ROLES

    can :read, UserGroup do |m|
      ( m.user_role.map {|role| role.user_id}).include? user.id
    end

    can :edit, UserGroup do |m|
      ( m.user_role.map {|role| [role.user_id, role.role] }).include? [user.id, "ROLE_PROFESSIONAL"]
    end

    can :create, UserRole do |m|
      (m.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PATIENT"]
    end

    can :create, UserRole do |m|
      m.role = "ROLE_VIEWER" and
      (m.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PATIENT"]
    end

    # ANSEWR
    can :edit, Answer do |m|
      (m.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PATIENT"]
    end

    can :create, Answer do |m|
      (m.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PROFESSIONAL"]
    end

    # FLAG
    can [:create,:edit, :delete], Flag do |m|
      (m.answer.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PROFESSIONAL"]
    end

    # POTENTIAL EDIT
    can [:read,:create], PotentialEdit do |m|
      (m.answer.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PROFESSIONAL"]
    end

    can [:read, :edit, :delete], PotentialEdit do |m|
      
      (m.answer.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PATIENT"]
    end

    # BUBBLE
    can [:update, :create], Bubble do |m|
      (m.user_group.user_role.map {|role| [role.user_id, role.role]}).include? [user.id,"ROLE_PATIENT"]
    end



    # USER
    can :edit, User, id: user.id

    # PREFERENCE
    can :edit, Preference, user: user


    # TEMP: For auth check
    can :manage, String
    
    return unless user.healthcare_professional?
    # Can read questions list

    can :read, Question
    
    can :create, UserGroup

    can :delete, EmotionalSupportRequest

    return unless user.admin?
    # Can manage everything

    can :manage, :all
  end
end
