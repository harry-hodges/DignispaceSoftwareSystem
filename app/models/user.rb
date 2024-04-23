# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  email       :string
#  email_token :string
#  hhash       :string
#  name        :string
#  role        :string
#  suspended   :boolean
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_email_token  (email_token)
#  index_users_on_token        (token)
#
class User < ApplicationRecord
  validates :name, :email ,presence: true

  has_many :alert
  
  def valid
    # TODO: ADD ACCOUNT SUSPENDED CHECK
    self.suspended != true
  end

  def healthcare_professional?
    return role == "ROLE_PROFESSIONAL" || role == "ROLE_ADMIN"
  end

  def admin?
    return role == "ROLE_ADMIN"
  end

  def user_details
    {
      name: self.name,
      profile_image: self.profile_image,
      id: self.id,
      support_requests: self.support_requests
    }
  end

  def add_token
    random_token = SecureRandom.urlsafe_base64(nil, false)
    self.token = random_token
    if self.save
      random_token
    else
      nil
    end
  end

  def logout
    self.token = nil
    self.save!
  end

  def remove_email_token
    self.email_token = nil
    self.save!
  end


  def self.send_confirm_email(user, title = "", text = "A login link has been requested", link = "/")
    random_token = SecureRandom.urlsafe_base64(nil, false)
    user.email_token = random_token
    user.save
    UserMailer.with(user: user, text: text, title: title, link: link).confirm_email.deliver_now
  end

  def self.token_or_null(token)
    return nil if token == "" || token == nil

    User.find_by(token: token)
  end

  def self.email_or_null(email)
    return nil if email == "" || email == nil || email == "CONFIRMED"
    User.find_by(email_token: email)
  end

  def profile_image
    PhotoBackend.get_profile_proto self.email
  end

  def support_requests
    EmotionalSupportRequest.where(user_id: self.id)
  end

  def as_json(options = {})
    super(options.merge(except: [:hhash, :token, :email_token], include: [:support_requests]))
  end

  def email_lower
    self.email.downcase!
  end
  before_save :email_lower
end
