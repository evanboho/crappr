class Post < ActiveRecord::Base
  
  has_many :comments
  belongs_to :user
  
  before_save :downcase
  
  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :maximum => 144 }


  def downcase
    self.content = self.content.downcase
    replace_qs
  end
  
  def replace_qs
    c = self.content.split('q')
    self.content = c.join('2')
  end
  
end
