class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
			t.string "token_salt"
			t.datetime "valid_until"
			t.string "token_final"
      t.timestamps
    end
  end
end
