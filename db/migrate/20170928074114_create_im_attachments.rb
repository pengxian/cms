class CreateImAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :im_attachments, options: 'CHARSET=utf8' do |t|

      t.integer :im_post_id, comment: '帖子ID'
      t.attachment :pic, comment: '图片'
      t.integer :user_id, comment: '创建人'
      t.timestamps
    end
  end
end
