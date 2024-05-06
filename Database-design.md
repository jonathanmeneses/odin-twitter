Data Structure
User Model

Attributes: username, email, encrypted_password (handled by Devise), profile_picture (optional for now, can be handled by Active Storage later).
Associations: has_many :posts, has_many :likes, has_many :comments, has_many :followers, has_many :following.
Post Model

Attributes: content (text), user_id (references the User model).
Associations: belongs_to :user, has_many :comments, has_many :likes.
Comment Model

Attributes: content (text), user_id, post_id (both referencing their respective models).
Associations: belongs_to :user, belongs_to :post.
Like Model

Attributes: user_id, post_id (referencing User and Post respectively, consider making this unique together to prevent multiple likes on one post by the same user).
Associations: belongs_to :user, belongs_to :post.

Follower/Following Relationships

This can be a self-referential association in the User model. You might use a join table (relationships) with follower_id and followed_id both referencing the User model.