class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :poster
      t.string :year
      t.integer :rating, :default => 0
      t.string :comment
    end

  end
end
