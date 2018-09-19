# == Schema Information
#
# Table name: comments
#
#  id                :bigint(8)        not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :post
  
  belongs_to :author,
  foreign_key: :author_id,
  class_name: :User
  
  has_many :child_comments,
  foreign_key: :parent_comment_id,
  class_name: :Comment,
  dependent: :destroy
  
  belongs_to :parent_comment,
  foreign_key: :parent_comment_id,
  class_name: :Comment,
  optional: true
  
  has_many :votes, as: :votable
end
