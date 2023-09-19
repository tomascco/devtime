# == Schema Information
#
# Table name: accounts
#
#  id            :bigint           not null, primary key
#  api_token     :string
#  email         :citext           not null
#  password_hash :string
#  status        :integer          default("unverified"), not null
#  timezone      :string           default("UTC")
#
# Indexes
#
#  index_accounts_on_email  (email) UNIQUE WHERE (status = ANY (ARRAY[1, 2]))
#
class Account < ApplicationRecord
  include Rodauth::Rails.model
  enum :status, unverified: 1, verified: 2, closed: 3

  has_many :appointments, dependent: :destroy
  has_many :appointment_kinds, dependent: :destroy
  has_many :summaries, dependent: :destroy

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
