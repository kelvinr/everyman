class Question < ActiveRecord::Base
  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }, as: :commentable

  validates_presence_of :user, :question
end
