class Admin::DashboardController < ApplicationController

    http_basic_authenticate_with name:ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']  

  def show
    @categories=Category.all
    # define an array to store product quantity of each category in hash
    count_products_by_category=@categories.map do |category|
      {category.name => Product.where(category_id:category.id).count }  
    end
    #calculate total products 
    total_products=count_products_by_category.sum {|item|item.values.first}   

    render locals: {
      count_products_by_category:count_products_by_category,
      total_products:total_products
    }

  end

end
