class CreateTopicAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_attachments, options: 'CHARSET=utf8' do |t|

      t.integer :topic_id, comment: '问答ID'
      t.attachment :pic, comment: '图片'
      t.integer :user_id, comment: '创建人'
      t.timestamps

    end
  end
end
