class CartsController < ApplicationController

  before_filter :authorize

  def show
    # check if cart is empty, then display a message, instead of the empty cart list
    if enhanced_cart.length==0      
      @message="Your cart is empty. Please go to the home page to add some products first." 
    end
    render :show
  end

  def add_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, +1)

    redirect_to :back
  end

  def remove_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, -1)

    redirect_to :back
  end

  private

  def modify_cart_delta(product_id, delta)
    cart[product_id] = (cart[product_id] || 0) + delta
    cart.delete(product_id) if cart[product_id] < 1
    update_cart cart
  end

end
