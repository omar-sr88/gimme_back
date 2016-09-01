class NotificationSenderJob < ApplicationJob
  queue_as :default

 def perform(event)
    ActionCable.server.broadcast 'activity_channel', notification: render_notification(event)
  end
 
  private
 
  def render_notification(event)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: event })
  end

end
