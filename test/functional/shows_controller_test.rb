require 'test_helper'

class ShowsControllerTest < ActionController::TestCase
  setup do
    @show = shows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create show" do
    assert_difference('Show.count') do
      post :create, show: { backdrop_path: @show.backdrop_path, first_air_date: @show.first_air_date, folder: @show.folder, id: @show.id, name: @show.name, original_name: @show.original_name, overview: @show.overview, popularity: @show.popularity, poster_path: @show.poster_path, vote_average: @show.vote_average, vote_count: @show.vote_count }
    end

    assert_redirected_to show_path(assigns(:show))
  end

  test "should show show" do
    get :show, id: @show
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @show
    assert_response :success
  end

  test "should update show" do
    put :update, id: @show, show: { backdrop_path: @show.backdrop_path, first_air_date: @show.first_air_date, folder: @show.folder, id: @show.id, name: @show.name, original_name: @show.original_name, overview: @show.overview, popularity: @show.popularity, poster_path: @show.poster_path, vote_average: @show.vote_average, vote_count: @show.vote_count }
    assert_redirected_to show_path(assigns(:show))
  end

  test "should destroy show" do
    assert_difference('Show.count', -1) do
      delete :destroy, id: @show
    end

    assert_redirected_to shows_path
  end
end
