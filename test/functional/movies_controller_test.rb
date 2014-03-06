require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post :create, movie: { added: @movie.added, backdrop_path: @movie.backdrop_path, budget: @movie.budget, filename: @movie.filename, id: @movie.id, imdb_id: @movie.imdb_id, original_title: @movie.original_title, overview: @movie.overview, popularity: @movie.popularity, poster_path: @movie.poster_path, release_date: @movie.release_date, revenue: @movie.revenue, runtime: @movie.runtime, status: @movie.status, tagline: @movie.tagline, title: @movie.title, vote_average: @movie.vote_average, vote_count: @movie.vote_count }
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie
    assert_response :success
  end

  test "should update movie" do
    put :update, id: @movie, movie: { added: @movie.added, backdrop_path: @movie.backdrop_path, budget: @movie.budget, filename: @movie.filename, id: @movie.id, imdb_id: @movie.imdb_id, original_title: @movie.original_title, overview: @movie.overview, popularity: @movie.popularity, poster_path: @movie.poster_path, release_date: @movie.release_date, revenue: @movie.revenue, runtime: @movie.runtime, status: @movie.status, tagline: @movie.tagline, title: @movie.title, vote_average: @movie.vote_average, vote_count: @movie.vote_count }
    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

    assert_redirected_to movies_path
  end
end
