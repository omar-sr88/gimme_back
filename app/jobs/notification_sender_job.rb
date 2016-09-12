class NotificationSenderJob < ApplicationJob
  queue_as :default

 def perform(event)
 	target_id = event.to.id
    ActionCable.server.broadcast "activity_channel_#{target_id}", notification: render_notification(event)
  end
 
  private
 
  def render_notification(event)
    ApplicationController.renderer.render(partial: 'notifications/nav_notification', locals: { notification: event })
  end

end
