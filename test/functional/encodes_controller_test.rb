require 'test_helper'

class EncodesControllerTest < ActionController::TestCase
  setup do
    @encode = encodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:encodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create encode" do
    assert_difference('Encode.count') do
      post :create, encode: { a_bitrate: @encode.a_bitrate, a_format: @encode.a_format, a_stream_size: @encode.a_stream_size, aspect_ratio: @encode.aspect_ratio, container: @encode.container, duration: @encode.duration, framerate: @encode.framerate, resolution: @encode.resolution, rip_date: @encode.rip_date, size: @encode.size, v_bitrate: @encode.v_bitrate, v_codec: @encode.v_codec, v_format: @encode.v_format, v_profile: @encode.v_profile, v_stream_size: @encode.v_stream_size }
    end

    assert_redirected_to encode_path(assigns(:encode))
  end

  test "should show encode" do
    get :show, id: @encode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @encode
    assert_response :success
  end

  test "should update encode" do
    put :update, id: @encode, encode: { a_bitrate: @encode.a_bitrate, a_format: @encode.a_format, a_stream_size: @encode.a_stream_size, aspect_ratio: @encode.aspect_ratio, container: @encode.container, duration: @encode.duration, framerate: @encode.framerate, resolution: @encode.resolution, rip_date: @encode.rip_date, size: @encode.size, v_bitrate: @encode.v_bitrate, v_codec: @encode.v_codec, v_format: @encode.v_format, v_profile: @encode.v_profile, v_stream_size: @encode.v_stream_size }
    assert_redirected_to encode_path(assigns(:encode))
  end

  test "should destroy encode" do
    assert_difference('Encode.count', -1) do
      delete :destroy, id: @encode
    end

    assert_redirected_to encodes_path
  end
end
