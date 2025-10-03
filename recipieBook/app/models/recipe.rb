class Recipe < ApplicationRecord
    validates :title, presence: true
    validates :cook_time, presence: true
    validates :difficulty, presence: true
    validates :instructions, presence: true

    has_rich_text :instructions
end
