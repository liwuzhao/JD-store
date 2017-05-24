module ProductsHelper
  def render_product_collection_state(product)
     if !current_user.is_collect_of?(product)
       link_to("", collect_product_path(product),:remote => true, method: :post, class: "show-heart1 fa fa-heart ",style:"text-decoration:none;color:rgba(111,113,111 ,1);")
     else
       link_to("", un_collect_product_path(product),:remote=>true, method: :post,  class: "show-heart2 fa fa-heart ",style:"text-decoration:none;color:red;")
     end
  end
end
