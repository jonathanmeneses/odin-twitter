class Like < ApplicationRecord
  # Right now we're going to just have posts as likeable. I might want to make comments likeable as well in the future
  belongs_to :post
  belongs_to :user
end
