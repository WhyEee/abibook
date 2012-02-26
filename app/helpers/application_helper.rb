module ApplicationHelper
  def bootstrap_flash(key)
    if key == "notice"
      "success"
    elsif key == "alert"
      "error"
    else
      "info"
    end
  end
end
