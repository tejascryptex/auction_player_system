require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get players_create_url
    assert_response :success
  end

  test "should get destroy" do
    get players_destroy_url
    assert_response :success
  end
end
