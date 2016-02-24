class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :rated
      t.string :released
      t.string :runtime
      t.string :genre
      t.string :director
      t.string :writer
      t.string :actors
      t.string :plot
      t.string :language
      t.string :country
      t.string :awards
      t.string :poster
      t.string :metascore
      t.string :imbd_rating
      t.string :imbd_votes
      t.string :imbd_id
      t.string :film_type
      t.string :response
      t.string :error
      t.timestamps null: false
    end
  end
end
