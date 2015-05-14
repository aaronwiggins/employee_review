require 'minitest/autorun'
require 'minitest/pride'
require 'byebug'
#Note: This line is going to fail first.
require './employee.rb'
require './department.rb'

# $mock_inputs = []
# def get_user_input
#   $mock_inputs.shift
# end

class EmployeeDepartmentTest < Minitest::Test

  def test_can_create_new_department
    assert Department.new("Accounting")
  end

  def test_create_department_name
    assert_equal "Accounting", Department.new("Accounting").name
  end
end
# assert_equal "Bob", Employee.new("Bob").name
