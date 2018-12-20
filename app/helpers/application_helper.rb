module ApplicationHelper
  def change_flash_message(message) 
    case message
      when "notice"
        return "success"
      when "alert"
        return "warning"
      else
        return message
      end
  end
end
