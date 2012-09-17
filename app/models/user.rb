# encoding: UTF-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :provider, :uid, :name, :url
  # attr_accessible :title, :body

  has_many :tasks, :dependent => :destroy
  has_many :statistics
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
    end
    user
  end

def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    email = data.screen_name + "@twitter.com" 
    if user = self.find_by_email(email)
      user
    else 
      user = User.new(:name => data.screen_name,
                      :email => email, 
                      :password => Devise.friendly_token[0,20])
     
      user.save!
      user
    end
  end

  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = self.find_by_email(data.email)
      user
    else 
      user = User.new(:name => data.nickname,
                      :email => data.email, 
      	              :password => Devise.friendly_token[0,20]) 
     
      user.save!
      user
    end
  end

end
