# == Schema Information
#
# Table name: votes
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer          not null
#  value        :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  validates :user_id, :votable_id, :votable_type, :value, presence: true
  after_initialize :set_votable_type
  
  belongs_to :votable, polymorphic: true

  def set_votable_type
    self.votable_type = :Post
  end
end
