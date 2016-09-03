# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ActivityChannel < ApplicationCable::Channel
  def subscribed
      stream_from "activity_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify(data)
  	#n = Notification.third
  	#NotificationSenderJob.perform_later n
  	#n = Notification.create!(title: "test", message: "message", sender: User.second, to: User.first)
  end
end
