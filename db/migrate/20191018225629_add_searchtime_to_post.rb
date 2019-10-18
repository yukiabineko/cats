class AddSearchtimeToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :serch_date, :date
  end
end
