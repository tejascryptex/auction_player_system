require "test_helper"

class StaffMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get staff_members_create_url
    assert_response :success
  end

  test "should get destroy" do
    get staff_members_destroy_url
    assert_response :success
  end
end
