module ApplicationHelper

  def format_markdown(text)
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(text).html_safe
  end

  def active_li(path)
    content_tag :li, nil, class: current_page?(path) ? 'active' : '' do
      yield if block_given?
    end
  end

  def greeting(name)
    greetings = I18n.t('greetings')
    "#{greetings}, #{name}"
  end

end
