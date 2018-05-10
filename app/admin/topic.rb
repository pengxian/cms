ActiveAdmin.register Topic do

  permit_params :user_id, :creator_id, :content, :published_at, tag_ids: [], attachments_attributes: [:id, :pic, :user_id, :_destroy]

  # tag_ids对照表
  options = YAML::load_file("#{Rails.root}/config/options.yml").to_h['options'].to_h['topic'].to_h['tag_ids'].to_a.map{|k,v| { name: v, id: k }}

  index do
    selectable_column
    id_column
    column :creator_id
    column :status do |topic|
      status_tag 'active', class: topic.status_class, label: t("activerecord.enums.topic.status.#{topic.status}")
    end
    column :tag_ids do |topic|
      options.select{|x|topic.tag_ids.to_s.split(',').include?(x[:id].to_s)}.map{|x|x[:name]}.join(',')
    end
    column :content
    column :published_at
    column :attachment do |topic|
      if topic.attachments.present?
        topic.attachments.each_with_index{|att,_index|
          span do image_tag(att.pic.url(:small), height: '50', width: '50') end
        }
      else
         :null
      end
    end
    actions
  end

  filter :status
  filter :creator_id_equals
  filter :status
  filter :tag_ids
  filter :content
  filter :published_at

  form do |f|
    f.inputs do
      f.object.creator_id
      f.input :creator_id, required: true
      collected_data = options.map{|x| [x[:name], x[:id], {checked: f.object.tag_ids.to_s.split(',').include?(x[:id].to_s)}]}
      if collected_data.blank?
        f.input :tag_ids
      else
        f.input :tag_ids, as: :check_boxes, collection: collected_data
      end
      f.input :content, :as => 'text'
      f.object.published_at ||= Time.zone.now # 新建默认时间为现在
      f.input :published_at, required: true
      f.has_many :attachments, allow_destroy: true, new_record: true do |a|
        a.input :pic, required: true, :as => :file, :label => "Image",:hint => a.template.image_tag(a.object.pic.url(:small))
      end
    end
    f.actions
  end

end
