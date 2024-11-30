class ApplicationController < ActionController::Base
    protected

  # ログイン後のリダイレクト先をトップページ（root_path）に設定
  def after_sign_in_path_for(resource)
    root_path #ログイン画面に遷移
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path #ログイン画面に遷移
  end

end
