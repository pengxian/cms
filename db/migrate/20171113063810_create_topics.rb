class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics, options: 'CHARSET=utf8' do |t|

      t.integer :user_id, comment: '后台用户'
      t.integer :creator_id, comment: '创建人'
      t.integer :status, comment: '状态'
      t.string :tag_ids, comments: '标签ID'
      t.string :content, limit: 1200, comments: '内容'
      t.datetime :published_at, comments: '发布时间'
      t.integer :lock_version, null: false, default: 0, comment: '版本锁定'
      t.timestamps

    end
  end
end
