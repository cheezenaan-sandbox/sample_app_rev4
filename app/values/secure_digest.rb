# frozen_string_literal: true

class SecureDigest
  class << self
    def create(secret)
      new(BCrypt::Password.create(secret, cost: cost))
    end

    def digest(secret)
      create(secret).digest
    end

    private

    def cost
      ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    end
  end

  def initialize(hash)
    @hash = hash
    @salt = salt_from(hash)
  end

  def digest
    @hash
  end

  def ==(other)
    BCrypt::Engine.hash_secret(other, @salt) == @hash
  end
  alias is_digest? ==

  private

  def salt_from(hash)
    hash[0, 29].to_str
  end
end
