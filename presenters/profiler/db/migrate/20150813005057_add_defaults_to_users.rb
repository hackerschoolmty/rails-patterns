class AddDefaultsToUsers < ActiveRecord::Migration
  def self.up
    change_column_default :users, :image_url, "http://placehold.it/200x200"
    change_column_default :users, :name, "No name given"
    change_column_default :users, :username, "No username given"
    change_column_default :users, :email, "No email given"
    change_column_default :users, :website, "No website given"
    change_column_default :users, :github, "No github given"
    change_column_default :users, :twitter, "No twitter given"
    change_column_default :users, :bio, "No bio given"
  end

  def self.down
    change_column_default :users, :image_url, nil
    change_column_default :users, :name, nil
    change_column_default :users, :username, nil
    change_column_default :users, :email, nil
    change_column_default :users, :website, nil
    change_column_default :users, :github, nil
    change_column_default :users, :twitter, nil
    change_column_default :users, :bio, nil
  end
end
