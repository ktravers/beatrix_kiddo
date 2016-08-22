module ApplicationHelper

  def link_to_dumbo_map(title)
    content_tag(:a, title, href: 'https://www.google.com/maps/place/Dumbo,+Brooklyn,+NY+11201/data=!4m2!3m1!1s0x89c25a316f3eb0fb:0xceb1d92c1cafc9c3?sa=X&ved=0ahUKEwiqn__Q19POAhXLlB4KHTrmDX4Q8gEIjgEwDw'
    )

  end

  def email_validation
    "^[-a-zA-Z0-9~!$%^&*_=+}{\'?]+(\.[-a-zA-Z0-9~!$%^&*_=+}{\'?]+)*@([a-zA-Z0-9_][-a-zA-Z0-9_]*(\.[-a-zA-Z0-9_]+)*.([a-zA-Z]+)|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$"
  end

  # https://gist.github.com/JosepMartins/7091420d90300870f347
  def svg_tag(id, options = {})
    klass, fill = options[:class], options[:fill]
    width, height = options[:width], options[:height]

    content_tag(:svg,
      content_tag(:use, '', {'xlink:href' => image_path('sprite.svg#' + id, host: request.host_with_port)}),
      class: (klass if klass),
      width: (width if width),
      height: (height if height),
      fill: (fill if fill)
    )
  end

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
