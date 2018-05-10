class PostWorker
  include Sidekiq::Worker

  def perform(*args)
    post = ::ImPost.find_by_id(args[0])
    post.enqueue
  end
end
