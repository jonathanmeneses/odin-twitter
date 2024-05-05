class Like < ApplicationRecord
  # Right now we're going to just have posts as likeable. I might want to make comments likeable as well in the future
  belongs_to :likeable, polymorphic: true
  belongs_to :user
end
