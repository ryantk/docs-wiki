module ApplicationHelper

  def format_markdown(text)
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(text).html_safe
  end

end
