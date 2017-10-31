class Goal < ApplicationRecord
  validates :title, :body, presence: true
  validates :private, inclusion: { in: [true, false] }
  validates :title, uniqueness: { scope: :user_id }

  belongs_to :user
end
