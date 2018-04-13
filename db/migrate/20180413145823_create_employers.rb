class CreateEmployers < ActiveRecord::Migration[5.0]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :age
      t.string :gender
      t.string :reset_token

      t.timestamps
    end
  end
end
