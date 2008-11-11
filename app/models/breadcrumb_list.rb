module BreadcrumbList
  include Radiant::Taggable
  include ActionView::Helpers::TagHelper
  
  desc %{
    Renders a trail of breadcrumbs to the current page, rendered as an undordered list. The id and class attributes specify the HTML id and HTML class, respectively, of the containing unordered list. The boolean nolinks attribute can be specified to render breadcrumbs in plain text, without any links (useful when generating title tag).

    *Usage:*
    <pre><code><r:breadcrumb_list [nolinks="true"] [id="id"] [class="class"] [separator="/"] /></code></pre>
  }
  tag 'breadcrumb_list' do |tag|
    page = tag.locals.page
    separator = tag.attr['separator']
    validSeparator = separator != nil && separator != ""
    breadcrumbs =  validSeparator ? [ separator + " " + page.breadcrumb] : [page.breadcrumb]
    nolinks = (tag.attr['nolinks'] == 'true')
    page.ancestors.each do |ancestor|
      tag.locals.page = ancestor
      if nolinks
        breadcrumbs.unshift validSeparator ? separator + " " + tag.render('breadcrumb') : "" + tag.render('breadcrumb')
      else
        if validSeparator
          breadcrumbs.unshift %{#{separator} <a href="#{tag.render('url')}">#{tag.render('breadcrumb')}</a>}
        else
          breadcrumbs.unshift %{<a href="#{tag.render('url')}">#{tag.render('breadcrumb')}</a>}
        end
      end
    end
    content_tag(:ul, breadcrumbs.map {|breadcrumb| content_tag(:li, breadcrumb)}, { :id => tag.attr['id'], :class => tag.attr['class'] })
  end

end