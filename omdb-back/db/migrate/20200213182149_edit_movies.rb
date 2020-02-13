class EditMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :comment, :string
  end
end
