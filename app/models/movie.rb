class Movie < ApplicationRecord
    validates :name, presence: true, length: { maximum: 40 } 
    validates :rating, presence: true, numericality: { only_integer: true, in: 1..11 }
end
