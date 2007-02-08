class ReorderExtension < Radiant::Extension
  version "1.0"
  description "Adds the ability to reorder the children of a page."
  url "http://dev.radiantcms.org/svn/radiant/branches/mental/extensions/reorder"

  define_routes do |map|
    map.page_reorder_children  'admin/pages/reorder/:id', :controller => 'admin/page', :action => 'reorder'
  end
  
  def activate
    Page.send :include, PageExtensions, TagExtensions
    Page.reflections[:children].options[:order] = "position ASC"
    
    require_dependency 'application'
    Admin::PageController.send :include, PageControllerExtensions
    Admin::PageController.send :helper, PageHelperExtensions
  end
  
  def deactivate
  end
    
end