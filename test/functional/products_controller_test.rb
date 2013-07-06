require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {

        :title => 'Lorem ipsum',
        :description => 'Wibbles are Fun'
        :image_url => "Lorem.jpg",
        :price => '$10.99'
      }
  end  
   
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', :minimum => 4 
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9' 
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
  

  test "should get new" do
    get :new
    assert_response :success
  end   

  test "should create product" do
    assert_difference('Product.count') do
      
      post :create, :product => @update
      #creates product with the validation parameters that are stated in product model and first product test
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product.to_param, :product => @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
