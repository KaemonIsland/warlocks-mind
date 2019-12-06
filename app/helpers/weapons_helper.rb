module WeaponsHelper
  def split_category(category)
    convert_category = lambda { |n| n.capitalize! }
    category.split("_").each(&convert_category).join(" ")
  end

  def nested_attributes_select(model)
    weapon_attr = [["---", nil]]
    model.where(user_id: current_user.id).each do |attr|
      weapon_attr << [attr.name, attr.id]
    end
    weapon_attr
  end
end
