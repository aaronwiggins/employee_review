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
    assert "Bob", Employee.new(name: "Bob").name
  end

  def test_create_employee_with_email
    assert_equal "Bob@email.com", Employee.new(email: "Bob@email.com").email
  end

  def test_create_employee_phone_number
    assert_equal "9192223333",
    Employee.new(phone_number: "9192223333").phone_number

  end

  def test_create_employee_salary
    assert_equal 95000, Employee.new(salary: 95000).salary

  end

  def test_department_can_be_given_an_employee
    name = Employee.new(name: "Bob")
    department = Department.new("Accounting")
    assert department.assign_employee(name)
  end

  def test_can_get_an_employee_name
    e_name = Employee.new(name: "Bob").name
    assert_equal "Bob", e_name
  end

  def test_can_get_an_employee_email
    e_email = Employee.new(email: "fake@gmail.com").email
    assert_equal "fake@gmail.com", e_email
  end

  def test_can_get_a_department_name
    assert_equal "Finance", Department.new("Finance").division
  end

  def test_get_department_salary_total
    department = Department.new("Accounting")
    employee_one = Employee.new(name: "Bob", salary: 75000).salary
    assert department.department_salary(employee_one)
    employee_two = Employee.new(name: "Bill", salary: 80000).salary
    assert department.department_salary(employee_two)
    assert_equal employee_two + employee_one, department.totals
  end
end
