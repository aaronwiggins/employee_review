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
    assert_equal "Accounting", Department.new("Accounting").division
  end

  def test_create_employee_name
    assert_equal "Bob", Employee.new(name: "Bob",
                                    email: "Bob@email.com",
                                    phone_number: "9192223333",
                                    salary: "95000").name
  end

  def test_create_employee_with_email
    assert_equal "Bob@email.com", Employee.new(name: "Bob",
                                    email: "Bob@email.com",
                                    phone_number: "9192223333",
                                    salary: "95000").email
  end

  def test_create_employee_phone_number
    assert_equal "9192223333", Employee.new(name: "Bob",
                                    email: "Bob@email.com",
                                    phone_number: "9192223333",
                                    salary: "95000").phone_number

  end

  def test_create_employee_salary
    assert_equal "95000", Employee.new(name: "Bob",
                                    email: "Bob@email.com",
                                    phone_number: "9192223333",
                                    salary: "95000").salary

  end

  def test_department_can_be_given_an_employee
    name = Employee.new(name: "Bob")                                  
    department = Department.new("Accounting")
    assert department.assign_employee(name)
  end
end
