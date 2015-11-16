class Groupmember < ActiveRecord::Base
  validates :group_id, :contact_id presence: true
  belongs_to :contact
  belongs_to :group
end
