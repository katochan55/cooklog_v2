class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
    # current_userに対する通知の集合を取得
    @notifications = Notification.where("user_id = ?", current_user.id)
    # 一度indexページを開いたら、ユーザーの「通知フラグ」を削除
    current_user.update_attribute(:notification, false)
  end
end
