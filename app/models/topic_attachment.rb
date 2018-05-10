class TopicAttachment < ApplicationRecord
  self.table_name = 'topic_attachments'

  belongs_to :user, class_name: 'AdminUser'
  belongs_to :topic, class_name: 'Topic'

  has_attached_file :pic,
    url: "/uploads/topic_attachment/:id/:style.:extension",
    :styles => { :small => ['220x220#'] },
    :convert_options => { :all => '-background white -flatten +matte' },
    default_url: "/default/placeholder.jpg"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\z/

end
