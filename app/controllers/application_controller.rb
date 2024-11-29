class ApplicationController < ActionController::Base
    protected

  # ログイン後のリダイレクト先をトップページ（root_path）に設定
  def after_sign_in_path_for(resource)
    root_path
  end
end
