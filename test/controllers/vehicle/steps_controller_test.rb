require "test_helper"

class Vehicle::StepsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get vehicle_steps_show_url
    assert_response :success
  end

  test "should get update" do
    get vehicle_steps_update_url
    assert_response :success
  end
end
