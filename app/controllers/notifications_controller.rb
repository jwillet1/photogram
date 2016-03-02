class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order('created_at DESC')
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end

  def read_all
    if current_user.notifications.where(read: false).count > 0
      current_user.notifications.where(read: false).update_all(read: true)
      flash[:success] = "All notifcations marked as read!"
      redirect_to notifications_path
    else
      flash[:alert] = "No unread notifcations"
      redirect_to notifications_path
    end
  end
end
