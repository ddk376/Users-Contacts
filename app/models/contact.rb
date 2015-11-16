class Contact < ActiveRecord::Base
  validates :name, :email, :owner, presence: true
  validates :email, :uniqueness => {:scope => :user_id}

  belongs_to :owner,
    class_name: 'User',
    foreign_key: :user_id

  has_many :shares,
    class_name: 'ContactShare',
    foreign_key: :contact_id

  has_many :shared_users,     # users who you (me, the contact) have been shared with
    through: :shares,
    source: :user

  has_many :comments, as: :commentable

end
