class AddTimestampsToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :pet_applications, null: true
  end
end
