class User < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => true

  has_many :contact, :dependent => :destroy       # owner of this contact

  has_many :shares,
    class_name: "ContactShare",
    foreign_key: :user_id,
    dependent: :destroy

  has_many :shared_contacts,    # which contacts been shared with me, the user
    through: :shares,
    source: :contact

  has_many :comments, as: :commentable
end
