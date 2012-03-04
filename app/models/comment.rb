class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  before_save :downcase
  
  validates :content, :presence => true, :length => {:minimum => 4}
  
  def downcase
    self.content = self.content.downcase
  end
  
end
