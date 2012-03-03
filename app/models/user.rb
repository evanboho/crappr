class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
   # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
        

   # Setup accessible (or protected) attributes for your model
   attr_accessible :email, :omniauth_facebook, :password, :password_confirmation, :screen_name, :bio, :remember_me
  
  
  has_many :posts
  has_many :comments
  
  # attr_accessor :password
  # before_save :encrypt_password
  
  # validates_confirmation_of :password
  # validates_presence_of :password, :on => :create
  # validates :screen_name, :presence => true, :uniqueness => true
  validates :email, :uniqueness => true, :on => :create
  validates :screen_name, :presence => true, :uniqueness => true, :length => { :minimum => 4 }
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      screen_name = data.email.split('@').first
      if User.where(:screen_name => screen_name).empty?
        User.new(:omniauth_facebook => true, :screen_name => screen_name, :email => data.email, :password => Devise.friendly_token[0,20]) 
      else
        screen_name = screen_name + '69'
        User.new(:omniauth_facebook => true, :screen_name => screen_name, :email => data.email, :password => Devise.friendly_token[0,20]) 
      end
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]# ["extra"]["raw_info"]
        user.email = data["email"]
        s = data["email"].split('@').first
        user.screen_name = s
        user.password = data["password"]
      end
    end
  end
  
  def password_required?
    (!omniauth_facebook || !encrypted_password.blank?) && super
  end
  
  
  
  def admin?
    
  end
  
  # def encrypt_password
  #     if password.present?
  #       self.password_salt = BCrypt::Engine.generate_salt
  #       self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  #     end
  #   end
  #   
  #   def self.authenticate(email, password)
  #     user = find_by_email(email)
  #     if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  #       user
  #     else
  #       nil
  #     end
  #   end
    
end
