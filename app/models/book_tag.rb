class WorkoutTag < ApplicationRecord
  has_many :post_book_tags, dependent: :destroy
  has_many :book, through: :post_book_tags

  validates :name, presence:true, length:{maximum:50}
end