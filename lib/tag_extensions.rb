module TagExtensions
  include Radiant::Taggable
  
  desc %{
    Page attribute tags inside this tag refer to the previous child page of the
    contextual parent page. The by and status attributes work the same way they do in the
    children:each tag. This tag only expands if the page exists.

    *Usage:*
    <pre><code><r:next [by="attribute"] [status="draft|reviewed|published|hidden|all"]>...</r:next></code></pre>
  }
  tag 'next' do |tag|
    if tag.attr['status']
      status_id = Status[tag.attr['status']].id
      equality = '='
    else
      status_id = Status[:draft].id
      equality = '!='
    end
    next_page = Page.with_scope(:find => { :conditions => ["status_id #{equality} ?", status_id] }) do
      tag.locals.page.next(tag.attr['by'] || :position)
    end
    if next_page
      tag.locals.page = next_page
      tag.expand
    end
  end
 
  desc %{   
    Page attribute tags inside this tag refer to the previous child page of the
    contextual parent page. The by and status attributes work the same way they do in the
    children:each tag. This tag only expands if the page exists.

    *Usage:*
    <pre><code><r:previous [by="attribute"] [status="draft|reviewed|published|hidden|all"]>...</r:previous></code></pre>
  }
  tag 'previous' do |tag|
    if tag.attr['status']
      status_id = Status[tag.attr['status']].id
      equality = '='
    else
      status_id = Status[:draft].id
      equality = '!='
    end
    target_page = Page.with_scope(:find => { :conditions => ["status_id #{equality} ?", status_id] }) do
      tag.locals.page.previous(tag.attr['by'] || :position)
    end
    if target_page
      tag.locals.page = target_page
      tag.expand
    end
  end
end