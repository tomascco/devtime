class Account < ApplicationRecord
  include Rodauth::Rails.model
  enum :status, unverified: 1, verified: 2, closed: 3

  has_many :hits, dependent: :destroy

  def add_api_token
    secret = ::Rails.application.secret_key_base
    payload = {time: Time.zone.now, account_id: id}
    self.api_token = JWT.encode(payload, secret, "HS256")
    save
  end

  def self.find_by_api_token(api_token)
    secret = ::Rails.application.secret_key_base
    decoded_token = JWT.decode(api_token, secret, true, {algorithm: "HS256"})
    account = Account.find(decoded_token[0]["account_id"])
    return account if ActiveSupport::SecurityUtils.secure_compare(api_token, account.api_token)

    :invalid_token
  rescue JWT::DecodeError
    :invalid_token
  rescue ActiveRecord::RecordNotFound
    :not_found
  end
end
