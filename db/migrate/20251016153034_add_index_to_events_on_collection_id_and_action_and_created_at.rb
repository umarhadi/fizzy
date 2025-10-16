class AddIndexToEventsOnCollectionIdAndActionAndCreatedAt < ActiveRecord::Migration[8.1]
  def change
    add_index :events, [ :collection_id, :action, :created_at ], name: "index_events_on_collection_id_and_action_and_created_at"
  end
end
