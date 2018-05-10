class ImAttachment < ApplicationRecord
  self.table_name = 'im_attachments'

  belongs_to :user, class_name: 'AdminUser'
  belongs_to :post, class_name: 'ImPost'


  has_attached_file :pic,
    url: "/uploads/im_attachment/:id/:style.:extension",
    :styles => { :small => ['220x220#'] },
    :convert_options => { :all => '-background white -flatten +matte' },
    default_url: "/default/placeholder.jpg"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\z/


end
