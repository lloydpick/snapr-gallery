# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # override options_for_select to fix any double escaped HTML entities
  #def options_for_select(*args)
  #  fix_double_escape(super(*args))
  #end
  
  # _roots_ is a collection of root items that will be traversed
  # other params are the same as options_from_collection_for_select
  # _initial_options_ is a collection of options added in front of the result (for the format see options_for_select)
  # If a block is given, _text_method_ is disabled (you may pass nil) and each item will be passed to the block, the returned value will be stringified and be used as the value. This way you may control the indentation string.
  # example to add the ancestors in the options:
  # options_from_tree_for_select(Category.find_all_by_parent_id(nil), :id, nil) {|item, depth| (item.ancestors.reverse << item).map(&:name).join("->") }
  # simply override the indentation padding:
  # options_from_tree_for_select(Category.find_all_by_parent_id(nil), :id, nil) {|item, depth| "---"*depth + item.name }
  def options_from_tree_for_select(roots, value_method, text_method, selected_value = nil, initial_options = nil)
    options_for_select(options_from_tree(roots, value_method, text_method, initial_options), selected_value)
  end
  
  def options_from_tree(roots, value_method, text_method, initial_options = nil)
    sub_items = lambda {|items, depth| items.inject([]) {|options, item| options << [block_given? ? yield(item, depth).to_s : ("---"*depth + item.send(text_method)), item.send(value_method)]; options += sub_items.call(item.children, depth+1) }}
    (initial_options || []) + sub_items.call(roots, 0)
  end

  
end
