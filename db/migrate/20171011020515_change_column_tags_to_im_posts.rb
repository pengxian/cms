class ChangeColumnTagsToImPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :im_posts, :tag_ids, :string
    remove_column :im_posts, :tags
  end
end
