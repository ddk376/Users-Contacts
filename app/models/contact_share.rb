class ContactShare < ActiveRecord::Base
  validates :user, :contact, presence: true
  validates :contact_id, uniqueness: {scope: :user_id}

  belongs_to :contact
  belongs_to :user


end
