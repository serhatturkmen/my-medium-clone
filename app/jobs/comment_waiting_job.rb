class CommentWaitingJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    comment = Comment.find(comment_id)
    if comment.created_at.eql?(comment.updated_at)
      comment.update(status: 1)
    end
    comment.update(locked: true)
  end
end
