module ApplicationHelper

  def link_to_remove_fields(name, f)
    f.input(:_destroy, :as => :hidden) + link_to_function(name, "remove_fields(this)", {:class => "remove_link"})
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.simple_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, raw("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), {:class => "add_link"})
  end

  def error_messages(obj)
    render 'shared/error_messages', :obj => obj
  end

  def watch_button(object, text = 'Watch')
    link_to text, { :controller=>"surveys", :action => "set_watching", :id => object[:id], :_ => rand }, {:remote => true, :id => "watch_#{object[:id]}", :method => :post} #, :class => [object[field_name.to_sym] ? 'tick' : 'cross']}
  end

end
