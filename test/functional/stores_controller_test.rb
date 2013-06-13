require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post :create, store: { address: @store.address, brand_type: @store.brand_type, name: @store.name, square_footage: @store.square_footage, status: @store.status, status: @store.status, store_number: @store.store_number, x_coord: @store.x_coord, y_coord: @store.y_coord }
    end

    assert_redirected_to store_path(assigns(:store))
  end

  test "should show store" do
    get :show, id: @store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store
    assert_response :success
  end

  test "should update store" do
    put :update, id: @store, store: { address: @store.address, brand_type: @store.brand_type, name: @store.name, square_footage: @store.square_footage, status: @store.status, status: @store.status, store_number: @store.store_number, x_coord: @store.x_coord, y_coord: @store.y_coord }
    assert_redirected_to store_path(assigns(:store))
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete :destroy, id: @store
    end

    assert_redirected_to stores_path
  end
end
