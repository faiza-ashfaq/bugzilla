# frozen_string_literal: true

require 'test_helper'

class ManagerControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get manager_index_url
    assert_response :success
  end

  test 'should get show' do
    get manager_show_url
    assert_response :success
  end

  test 'should get new' do
    get manager_new_url
    assert_response :success
  end

  test 'should get create' do
    get manager_create_url
    assert_response :success
  end
end
