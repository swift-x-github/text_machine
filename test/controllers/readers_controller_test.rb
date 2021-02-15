require 'test_helper'

class ReadersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get readers_index_url
    assert_response :success
  end

  test "should get show" do
    get readers_show_url
    assert_response :success
  end

end
