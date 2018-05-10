class Topic < ApplicationRecord
  self.table_name = 'topics'
  include AASM

  belongs_to :user, class_name: 'AdminUser'
  has_many :attachments, class_name: 'TopicAttachment' , dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :creator_id, :status, :published_at, presence: true

  before_save :scheduler_publish, if: :published_at_changed?
  before_save :gen_tag_ids, if: :tag_ids_changed?

  # progressing(初始化), timing(队列排队中), successed(发布成功), failed(发布失败)
  enum status: { progressing: 0, timing: 1, successed: 2,  failed: 3 }
  aasm column: :status, enum: true do
    state :progressing, :initial => true
    state :timing
    state :successed
    state :failed
    event :queue do
      transitions from: [:progressing,:failed,:successed], to: :timing
    end
    event :success do
      transitions from: :timing, to: :successed
    end
    event :fail do
      transitions from: :timing, to: :failed
    end
    event :init do
      transitions from: [:timing,:successed,:failed], to: :progressing
    end
  end

  def enqueue
    record = Moment::Service::Topic.new
    record.user_id = self.creator_id
    record.content = self.content
    record.pics = self.attachments.map{|a|Base64.strict_encode64(File.open(a.pic.path).read)}
    record.kind = 'opening'
    record.tag_ids =  self.tag_ids
    res = record.publish
    if res[:status] == 200
      self.success! if self.may_success?
    else
      self.fail! if self.may_fail?
    end
  end

  # 定时任务，根据published_at时间加入发布队列
  def scheduler_publish
    if self.published_at >= Time.zone.now
      Rufus::Scheduler.singleton.at self.published_at.strftime("%Y/%m/%d %H:%M:%S") do
        ::TopicWorker.perform_async(self.id)
      end
      self.queue if self.may_queue?
    else
      self.init if self.may_init?
    end
  end

  # 将表单传来的数据转化为字符串
  def gen_tag_ids
    self.tag_ids = JSON.parse(self.tag_ids).reject(&:empty?).join(',') if attribute_present?("tag_ids")
  end

  def status_class
    case self.status
    when 'progressing' then 'important'
    when 'timing' then 'warn'
    when 'successed' then 'ok'
    when 'failed' then 'error'
    end
  end

end
