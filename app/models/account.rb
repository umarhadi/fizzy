class Account < ApplicationRecord
  include Entropic, Joinable

  has_many_attached :uploads

  class << self
    def create_with_admin_user(tenant_id:, account_name:, owner_name:, owner_email:)
      account = create!(tenant_id:, name: account_name)

      User.create!(
        name:             owner_name,
        email_address:    owner_email,
        role:             "admin",
        password:         SecureRandom.hex(16)
      )

      account
    end
  end

  def slug
    "/#{tenant}"
  end

  def setup_basic_template
    user = User.first

    Closure::Reason.create_defaults
    Collection.create!(name: "Cards", creator: user, all_access: true)
  end
end
