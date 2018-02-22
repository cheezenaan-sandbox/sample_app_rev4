# frozen_string_literal: true

class CreateUserAccountActivations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_account_activations do |t|
      t.string :digest
      t.datetime :activated_at
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
