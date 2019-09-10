class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.date :plan_date
      t.string :plan_content
      t.references :cat, foreign_key: true

      t.timestamps
    end
  end
end
