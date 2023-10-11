class AddTypeToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :event_type, :integer
  end
end
