# frozen_string_literal: true

class SecureToken
  private_class_method :new
  attr_reader :token

  def initialize
    @token = SecureRandom.urlsafe_base64
  end

  class << self
    def create
      new.token
    end
  end
end
