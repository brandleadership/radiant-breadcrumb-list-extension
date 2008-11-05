class BreadcrumbListExtension < Radiant::Extension
  version "1.0"
  description "Renders a page's breadcrumbs as an undordered list."
  url "http://github.com/janson/radiant-breadcrumb-list-extension/"
  
  def activate
    Page.send :include, BreadcrumbList
  end
  
  def deactivate
  end
  
end