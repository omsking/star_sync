
class ChangeTextTimeToTextOptInInUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :text_time

    add_column :users, :text_opt_in, :boolean, :default => false
  end
end
