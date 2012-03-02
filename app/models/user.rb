class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
   # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

   # Setup accessible (or protected) attributes for your model
   attr_accessible :email, :password, :password_confirmation, :screen_name, :bio, :remember_me
  
  
  has_many :posts
  has_many :comments
  
  # attr_accessor :password
  # before_save :encrypt_password
  
  validates_confirmation_of :password
  # validates_presence_of :password, :on => :create
  # validates :screen_name, :presence => true, :uniqueness => true
  validates :email, :uniqueness => true, :on => :create
  validates :screen_name, :presence => true, :uniqueness => true, :length => { :minimum => 4 }
  
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
