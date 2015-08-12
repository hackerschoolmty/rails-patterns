class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.text :image_url
      t.string :username
      t.string :email
      t.string :website
      t.string :github
      t.string :twitter
      t.text :bio

      t.timestamps null: false
    end
  end
end
