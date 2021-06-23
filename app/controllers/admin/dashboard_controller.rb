class Admin::DashboardController < ApplicationController

    http_basic_authenticate_with name:ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']  

  def show
    @categories=Category.all
    # define an array to store product quantity for each category
    count_products_by_category=@categories.map do |category|
      Product.where(category_id:category.id).count      
    end

    render locals: {
      count_products_by_category:count_products_by_category
    }

  end

end
