module ApplicationHelper

  def user_events
    current_user.events.order(id: :asc)
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

  def formatted_date(date_string)
    return unless date_string
    date_string.strftime('%b %e, %Y')
  end
end
