require 'test_helper'

class GenresControllerTest < ActionController::TestCase
  setup do
    @genre = genres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genre" do
    assert_difference('Genre.count') do
      post :create, genre: { id: @genre.id, movie_id: @genre.movie_id, name: @genre.name }
    end

    assert_redirected_to genre_path(assigns(:genre))
  end

  test "should show genre" do
    get :show, id: @genre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genre
    assert_response :success
  end

  test "should update genre" do
    put :update, id: @genre, genre: { id: @genre.id, movie_id: @genre.movie_id, name: @genre.name }
    assert_redirected_to genre_path(assigns(:genre))
  end

  test "should destroy genre" do
    assert_difference('Genre.count', -1) do
      delete :destroy, id: @genre
    end

    assert_redirected_to genres_path
  end
end
