class RenameSplatsToBubbles < ActiveRecord::Migration[8.0]
  def change
    rename_table :splats, :bubbles

    rename_column :categorizations, :splat_id, :bubble_id
    rename_column :boosts, :splat_id, :bubble_id
    rename_column :comments, :splat_id, :bubble_id
  end
end
