class AddAuthorToPosts < ActiveRecord::Migration[5.1]
  # rails g migration add_author_to_posts creator:belongs_to
  
  def change
    add_reference :posts, :creator, foreign_key: true
  end

  # t.integer "creator_id"
  # t.index ["creator_id"], name: "index_posts_on_creator_id"
end
