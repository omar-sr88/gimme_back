class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
  	@notifications = @current_user.received_notifications.order(:created_at)
  	Notification.where(to_id: @current_user.id).update_all(seen: true)
  	session.delete(:messages_size)
  end
end
