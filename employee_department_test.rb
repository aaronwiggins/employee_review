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
    assert_equal "Bob@email.com", Employee.new(name: "Bob",email: "Bob@email.com").email
  end

  def test_create_employee_phone_number
    assert_equal "9192223333", Employee.new(name: "Bill", phone_number: "9192223333").phone_number

  end

  def test_create_employee_salary
    salary = Employee.new(name: "Tina", salary: 95000).salary
    assert_equal 95000, salary
  end

  def test_department_can_be_given_an_employee
    name = Employee.new(name: "Bob")
    department = Department.new("Accounting")
    assert department.assign_employee(name)
    assert_equal [name], department.employees
  end

  def test_can_get_an_employee_name
    employee = Employee.new(name: "Bob")
    assert_equal "Bob", employee.name
  end

  def test_can_get_an_employee_email
    employee = Employee.new(name: "Bill", email: "fake@gmail.com")
    assert_equal "fake@gmail.com", employee.email
  end

  def test_can_get_a_department_name
    department = Department.new("Finance")
    assert_equal "Finance", department.division
  end

  def test_get_department_salary_total
    department = Department.new("Accounting")
    employee_one = Employee.new(name: "Bob", salary: 75000)
    assert department.assign_employee(employee_one)
    employee_two = Employee.new(name: "Bill", salary: 80000)
    assert department.assign_employee(employee_two)
    assert_equal 155000, department.department_salaries
  end

  def test_employee_has_no_review_paperwork
    employee = Employee.new(name: "Bob")#, review_text: "none")
    assert_equal "", employee.review_text
  end

  def test_employee_has_review_text
    employee = Employee.new(name: "Sam")
    review = Employee.new(name: "Sam", review_text: "Sam demonstrates outstanding written
    communications skills. She listens carefully, asks perceptive questions, and
    quickly comprehends new or highly complex matters. She implements highly
    effective and often innovative communication methods. Sam displays very good
    verbal skills, communicating clearly and concisely. She is careful to keep
    others informed in a timely manner.").review_text
    assert employee
    assert review
    assert_equal "Sam demonstrates outstanding written
    communications skills. She listens carefully, asks perceptive questions, and
    quickly comprehends new or highly complex matters. She implements highly
    effective and often innovative communication methods. Sam displays very good
    verbal skills, communicating clearly and concisely. She is careful to keep
    others informed in a timely manner.", review
    assert employee.assign(review)
    assert_equal [review], employee.review_file
  end

  def test_employee_has_good_or_bad_review
    employee_one = Employee.new(name: "Sam")
    refute employee_one.review_rating == "good"
    employee_two = Employee.new(name: "Jean", review_rating: "good")
    assert "good", employee_two.review_rating
  end

  def test_does_employee_deserve_a_raise
    employee_two = Employee.new(name: "Jean", review_rating: "good")
    assert_equal true, employee_two.deserve_raise
  end

  def test_employee_receives_salary_raise
    employee_one = Employee.new(name: "Jean", salary: 80000, review_rating: "good")
    employee_one.give_raise(0.03)
    assert_equal 80000*1.03, employee_one.salary
  end

  def test_add_employees_to_department
    employee_one = Employee.new(name: "Bob", salary: 75000, review_rating: "good")
    department = Department.new("Accounting")
    employee_two = Employee.new(name: "Jean", salary: 80000, review_rating: "bad")
    employee_three = Employee.new(name: "Kim", salary: 85000, review_rating: "bad")
    employee_four = Employee.new(name: "Son", salary: 90000, review_rating: "good")
    department.assign_employee(employee_one)
    department.assign_employee(employee_two)
    department.assign_employee(employee_three)
    department.assign_employee(employee_four)

    assert_equal [employee_one, employee_two, employee_three, employee_four],
    department.employees
    assert_equal 330000, department.department_salaries
    department.distribute_raise(5000)
    assert_equal 335000, department.department_salaries
  end

end
