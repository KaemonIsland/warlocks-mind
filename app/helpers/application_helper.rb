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

  def full_title(page_title = '')
    title = "Warlocks Mind"
    page_title.empty? ? title : "#{page_title} | #{title}"
  end
end
