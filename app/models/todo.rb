class Todo < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
