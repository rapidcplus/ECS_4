module ApplicationHelper
  def get_youtube_shorts_id(url)
    if url.include?('youtube.com/shorts/')
      video_id = url.split('youtube.com/shorts/')[1].split('?')[0]
      return video_id
    end
    nil
  end

  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-info"   # 成功メッセージ用
    when :danger then "bg-accent"  # 警告メッセージ用
    else "bg-gray-500"             # エラーメッセージ用とその他のメッセージ用
    end
  end

  def mask_phone_number(phone_number)
    phone_number.gsub(/(\d{3})\d*(\d{2})$/, '\1******\2')
  end

  def message_background_color(message)
    case message
    when 'notice' then 'bg-blue-500'
    when 'alert' then 'bg-red-500'
    else 'bg-gray-500'
    end
  end
end
