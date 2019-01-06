module WeaponsHelper
  def split_category(category)
    convert_category = lambda { |n| n.capitalize! }
    category.split("_").each(&convert_category).join(" ")
  end
end
