# frozen_string_literal: true

class AddRemberDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :remember_digest, :string
  end
end
