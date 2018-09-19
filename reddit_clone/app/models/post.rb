# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :author,
  foreign_key: :author_id,
  class_name: :User
  
  has_many :post_subs,
  foreign_key: :post_id,
  class_name: :PostSub,
  dependent: :destroy
  
  has_many :subs,
  through: :post_subs,
  source: :sub,
  dependent: :destroy
  
  has_many :comments
  
  has_many :votes, 
  as: :votable,
  class_name: :Vote
  
  def total_votes
    sum = 0
    self.votes.each do |vote|
      sum += vote.value
    end
    sum
  end
end
