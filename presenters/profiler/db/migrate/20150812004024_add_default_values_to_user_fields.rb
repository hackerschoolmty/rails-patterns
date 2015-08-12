class AddDefaultValuesToUserFields < ActiveRecord::Migration
  def change
    change_column_default :users, :image_url, "http://placehold.it/200x200"
    change_column_default :users, :name, "No name given"
    change_column_default :users, :email, "No email given"
    change_column_default :users, :username, "No username given"
    change_column_default :users, :website, "No website given"
    change_column_default :users, :github, "No github given"
    change_column_default :users, :twitter, "No twitter given"
    change_column_default :users, :bio , "No bio given"
  end
end
