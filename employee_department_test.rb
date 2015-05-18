require 'minitest/autorun'
require 'minitest/pride'
require 'byebug'
require './employee.rb'
require './department.rb'


class EmployeeDepartmentTest < Minitest::Test

  def test_can_create_new_department
    assert Department.new("Accounting")
  end

  def test_create_department_name
    assert_equal "Accounting", Department.new("Accounting").division
  end

  def test_create_employee_name
    employee_one = Employee.new(name: "Bob")
    assert_equal "Bob", employee_one.name
  end

  def test_create_employee_with_email
    employee_one = Employee.new(name: "Bob",email: "Bob@email.com")
    assert_equal "Bob@email.com", employee_one.email
  end

  def test_create_employee_phone_number
    employee_one = Employee.new(phone_number: "9192223333", name: "Bill", )
    assert_equal "9192223333", employee_one.phone_number

  end

  def test_create_employee_salary
    employee_one = Employee.new(name: "Tina", salary: 95000)
    assert_equal 95000, employee_one.salary
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
    employee = Employee.new(name: "Bob")
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
    assert_equal "Sam demonstrates outstanding written
    communications skills. She listens carefully, asks perceptive questions, and
    quickly comprehends new or highly complex matters. She implements highly
    effective and often innovative communication methods. Sam displays very good
    verbal skills, communicating clearly and concisely. She is careful to keep
    others informed in a timely manner.", review
    assert employee.assign(review)
    assert_equal [review], employee.review_file
    assert_equal true, employee.deserve_raise
  end

  def test_employee_has_good_or_bad_review
    employee_one = Employee.new(name: "Sam")
    refute employee_one.review_rating == "good"
    employee_two = Employee.new(name: "Jean", review_rating: "good")
    assert "good", employee_two.review_rating
  end

  def test_does_employee_deserve_a_raise
    employee_two = Employee.new(name: "Jean")
    review = Employee.new(name: "Jean", review_text:"Jim continues to be a valued
    member of our crew and is a person we are able to count on. Jim's focus to his
    attendance and punctuality has made our core group operate significantly
    better over the past 12 months.").review_text
    employee_two.assign(review)
    assert_equal true, employee_two.deserve_raise
  end

  def test_employee_receives_salary_raise
    employee_one = Employee.new(name: "Jean", salary: 80000, review_rating: "good")
    employee_one.give_raise(0.03)
    assert_equal 80000*1.03, employee_one.salary
  end

  def test_add_employees_to_department_give_raise_to_good_employees
    employee_one = Employee.new(name: "Bob", salary: 75000, review_rating: "good")
    accounting = Department.new("Accounting")
    employee_two = Employee.new(name: "Jean", salary: 80000, review_rating: "bad")
    employee_three = Employee.new(name: "Kim", salary: 85000, review_rating: "bad")
    employee_four = Employee.new(name: "Son", salary: 90000, review_rating: "good")
    accounting.assign_employee(employee_one)
    accounting.assign_employee(employee_two)
    accounting.assign_employee(employee_three)
    accounting.assign_employee(employee_four)

    assert_equal [employee_one, employee_two, employee_three, employee_four],
    accounting.employees

    assert_equal 330000, accounting.department_salaries
    accounting.distribute_raise(5000) {|employee| employee.review_rating == "good"}
    assert_equal 335000, accounting.department_salaries
  end

  def test_add_criteria_for_raise
    employee_one = Employee.new(name: "Bob", salary: 75000, review_rating: "good")
    accounting = Department.new("Accounting")
    employee_two = Employee.new(name: "Jean", salary: 80000, review_rating: "good")
    employee_three = Employee.new(name: "Kim", salary: 85000, review_rating: "good")
    employee_four = Employee.new(name: "Son", salary: 90000, review_rating: "good")

    accounting.assign_employee(employee_one)
    accounting.assign_employee(employee_two)
    accounting.assign_employee(employee_three)
    accounting.assign_employee(employee_four)

    assert_equal [employee_one, employee_two, employee_three, employee_four],
    accounting.employees

    assert_equal 330000, accounting.department_salaries
    accounting.distribute_raise(10000) {|x| (x.salary < 85000)}
    assert_equal 340000, accounting.department_salaries
  end

  def test_review_good_or_bad
    employee_one = Employee.new(name: "Wanda")
    review = Employee.new(name: "Wanda", review_text: "Wanda has been an
    incredibly consistent and effective developer.  Clients are always satisfied
    with her work, developers are impressed with her productivity, and she's
    more than willing to help others even when she has a substantial workload of
    her own.  She is a great asset to Awesome Company, and everyone enjoys
    working with her.  During the past year, she has largely been devoted to
    work with the Cement Company, and she is the perfect woman for the job.  We
    know that work on a single project can become monotonous, however, so over
    the next few months, we hope to spread some of the Cement Company work to
    others.  This will also allow Wanda to pair more with others and spread her
    effectiveness to other projects.").review_text
    assert employee_one.assign(review)
    assert_equal true, employee_one.deserve_raise
  end

  def test_review_good_or_bad
    employee_one = Employee.new(name: "Yvonne")
    review = Employee.new(name: "Yvonne", review_text: "Thus far, there have been
    two concerns over Yvonne's performance, and both have been discussed with
    her in internal meetings.  First, in some cases, Yvonne takes longer to
    complete tasks than would normally be expected.  This most commonly manifests
    during development on existing applications, but can sometimes occur during
    development on new projects, often during tasks shared with Andrew.  In
    order to accommodate for these preferences, Yvonne has been putting more
    time into fewer projects, which has gone well. Second, while in
    conversation, Yvonne has a tendency to interrupt, talk over others, and
    increase her volume when in disagreement.  In client meetings, she also can
    dwell on potential issues even if the client or other attendees have clearly
    ruled the issue out, and can sometimes get off topic.").review_text
    assert employee_one.assign(review)
    assert_equal false, employee_one.deserve_raise
  end

  def test_review_good_or_bad
    employee_one = Employee.new(name: "Xavier")
    review = Employee.new(name: "Xavier", review_text: "Xavier is a huge asset to
    SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned
    to him, implements code that rarely needs to be revisited, and is always
    willing to help others despite his heavy workload.  When Xavier leaves on
    vacation, everyone wishes he didn't have to go. Last year, the only concerns
    with Xavier performance were around ownership.  In the past twelve months,
    he has successfully taken full ownership of both Acme and Bricks, Inc.
    Aside from some false starts with estimates on Acme, clients are happy with
    his work and responsiveness, which is everything that his managers could ask
    for.").review_text
    assert employee_one.assign(review)
    assert_equal true, employee_one.deserve_raise
  end

  def test_review_good_or_bad
    employee_one = Employee.new(name: "Wanda")
    review = Employee.new(name: "Wanda", review_text: "Zeke is a very positive
    person and encourages those around him, but he has not done well technically
    this year.  There are two areas in which Zeke has room for improvement.
    First, when communicating verbally (and sometimes in writing), he has a
    tendency to use more words than are required.  This conversational style
    does put people at ease, which is valuable, but it often makes the meaning
    difficult to isolate, and can cause confusion. Second, when discussing new
    requirements with project managers, less of the information is retained by
    Zeke long-term than is expected.  This has a few negative consequences: 1)
    time is spent developing features that are not useful and need to be re-run,
    2) bugs are introduced in the code and not caught because the tests lack the
    same information, and 3) clients are told that certain features are complete
    when they are inadequate.  This communication limitation could be the fault
    of project management, but given that other developers appear to retain more
    information, this is worth discussing further").review_text
    assert employee_one.assign(review)
    assert_equal false, employee_one.deserve_raise
  end

  def test_assert_bad_review
    employee_one = Employee.new(name: "Bob")
    review = Employee.new(name: "Bob", review_text: "Jack needs to work on his
    communication skills this next year. Effective communication requires more
    than just giving information when asked, Jack also needs to be proactive
    when engaging his team as issues come up. Also, Jack needs to work on the
    tone of his communication so listeners feel comfortable conversing with
    him.").review_text
    assert employee_one.assign(review)
    assert_equal false, employee_one.deserve_raise
  end

  def test_check_confidence_ratio
    employee_one = Employee.new(name: "Xavier", salary: 80000)
    accounting = Department.new("Accounting")
    review = Employee.new(name: "Xavier", review_text: "Xavier is a huge asset to
    SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned
    to him, implements code that rarely needs to be revisited, and is always
    willing to help others despite his heavy workload.  When Xavier leaves on
    vacation, everyone wishes he didn't have to go. Last year, the only concerns
    with Xavier performance were around ownership.  In the past twelve months,
    he has successfully taken full ownership of both Acme and Bricks, Inc.
    Aside from some false starts with estimates on Acme, clients are happy with
    his work and responsiveness, which is everything that his managers could ask
    for.").review_text
    assert employee_one.assign(review)
    assert_equal true, employee_one.deserve_raise
    accounting.assign_employee(employee_one)
    assert_equal [employee_one], accounting.employees
    assert_equal 80000, employee_one.salary
    assert_equal 6.54, employee_one.determine_review_score
    # accounting.distribute_raise(10000) {|x| (x.salary > 0.50)}
    # assert_equal 90000, accounting.department_salaries
  end
end
