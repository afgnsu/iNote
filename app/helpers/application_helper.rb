module ApplicationHelper
  def flash_message
    alert_types = { notice: :success, alert: :danger }
  
    close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag :button, "×", close_button_options
    
    alerts = flash.map do |type, message|
      alert_content = close_button + sanitize(message)
  
      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"
  
      content_tag :div, alert_content, class: alert_class 
    end
    
    alerts.join("\n").html_safe
  end

  def is_numeric(input)
    true if Integer(input) rescue false
  end  
  
  def new_link
    @link = Link.new
  end
  
  def youtube?(link)
    if link.include? "https://www.youtube.com/watch"
      true
    else
      false
    end
  end
  
  def embed_youtube(link)
    link.gsub 'https://www.youtube.com/watch?v=', 'https://www.youtube.com/embed/'
  end
  
end
