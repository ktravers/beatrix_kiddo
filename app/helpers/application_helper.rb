module ApplicationHelper

  def flash_class_for(flash_type)
    flash_types[flash_type.to_sym] || flash_type.to_s
  end

  def flash_types
    {
      success: 'green',
      error: 'red',
      warning: 'gold',
      notice: 'purple',
      alert: 'red'
    }
  end
end
