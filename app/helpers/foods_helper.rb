module FoodsHelper
  def get_list_status
    Food.status_foods.keys
  end
end
