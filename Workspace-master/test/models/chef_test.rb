require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(name: "joe", email: "joe@example.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "name should be present" do
    @chef.name = ""
    assert_not @chef.valid?
  end

  test "name length should not be more than 25" do
    @chef.name = "A"*26
    assert_not @chef.valid?
  end

  test "name length should not be less than 3" do
    @chef.name = "AA"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test "email length should not be more than 30" do
    @chef.email = "A"*31
    assert_not @chef.valid?
  end

  test "email length should not be less than 5" do
    @chef.email = "A"*4
    assert_not @chef.valid?
  end

  test "email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email should be valid with correct format" do
    valid_addresses = %w[joe.joe@example.com JOE.99JOE@Example.com 1234567890@gmail.com]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email should not be valid with incorrect format" do
    invalid_addresses = %w[joe.joe#example.com abc,dsfj@gmail,com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, "#{ia.inspect} is not valid"
    end
  end


end