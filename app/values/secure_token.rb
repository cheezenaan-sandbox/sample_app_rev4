# frozen_string_literal: true

class SecureToken
  attr_reader :token

  class << self
    def create
      new.token
    end
  end

  def initialize
    @token = SecureRandom.urlsafe_base64
  end

  private_class_method :new
end
