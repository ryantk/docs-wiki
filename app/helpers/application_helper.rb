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

  def gravatar(opts = {})
    email   = opts.fetch(:email)
    size    = opts.fetch(:size, 20)
    default = opts.fetch(:default, 'monsterid')
    hash    = Digest::MD5.hexdigest(email)

    "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=#{default}"
  end

end
