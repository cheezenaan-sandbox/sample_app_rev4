# frozen_string_literal: true

class SecureDigest
  attr_reader :string

  def initialize(string:)
    @string = string
  end

  def digest
    cost =
      ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def ==(other)
    string == other.string
  end

  protected :string
end
