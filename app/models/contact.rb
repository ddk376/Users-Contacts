class Contact < ActiveRecord::Base
  validates :name, :email, :owner, presence: true
  validates :email, :uniqueness => {:scope => :user_id}

  belongs_to :owner,
    class_name: 'User',
    foreign_key: :user_id

  has_many :contact_shares,
    class_name: 'ContactShare',
    foreign_key: :contact_id

  has_many :shared_users,     # users who you (me, the contact) have been shared with
    through: :shares,
    source: :user

  has_many :comments, as: :commentable

  belongs_to :groupmember

  def self.contacts_for_user_id(user_id)
    # SELECT
    #   contacts.*
    # FROM
    #   contacts
    # JOIN
    #   contact_shares ON contact_shares.contact_id = contacts.id
    # JOIN
    #   users ON users.id = contact_shares.user_id
    # WHERE
    #   "contact_shares.user_id = ? OR contacts.user_id = ?"
    joins_cond = <<-SQL
      LEFT OUTER JOIN
        contact_shares ON contact.id = contact_shares.contact_id
    SQL

    where_cond = <<-SQL
      ((contact_user_id) = :user_id ) OR (contact_shares.user_id = :user_id)
    SQL

    # contact = Contact
    #   .joins("JOIN contact_shares ON contact_shares.contact_id = contacts.id
    #          JOIN users ON users.id = contact_shares.user_id")
    #   .where("contact_shares.user_id = ? OR contacts.user_id = ?", user_id, user_id)

    Contact
      .joins(joins_cond)
      .where(where_cond, :user_id => user_id)
      .uniq
  end
end
