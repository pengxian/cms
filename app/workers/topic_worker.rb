class TopicWorker
  include Sidekiq::Worker

  def perform(*args)
    topic = ::Topic.find_by_id(args[0])
    topic.enqueue
  end

end
