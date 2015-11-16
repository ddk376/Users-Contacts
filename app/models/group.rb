class Group < ActiveRecord::Base
  validates :group_name, presence: true, uniqueness: true
  belongs_to :user

  has_many :groupmembers

  has_many :contacts_of_group_members,
    through: :groupmembers,
    source: :contact
end
