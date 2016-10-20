require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create(name: "bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "Chicken Soup", summary: "Best soup for when you get sick", description: "boil water in a pan, add chicken broth, add some vegetables, cut grilled chicken into small pieces, add them to the boiling water and stir them fro about 10 min.")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "there should be a chef_id for every recipe" do
    @recipe.chef_id = ""
    assert_not @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = nil
    assert_not @recipe.valid?
  end

  test "name length should not be more than 100" do
    @recipe.name = "A"*101
    assert_not @recipe.valid?
  end

  test "name length should not be less than 5" do
    @recipe.name = "A"*4
    assert_not @recipe.valid?
  end

  test "summary must be present" do
    @recipe.summary = ""
    assert_not @recipe.valid?
  end

  test "summary length should not be more than 150" do
    @recipe.summary = "A"*151
    assert_not @recipe.valid?
  end

  test "summary length should not be less than 10" do
    @recipe.summary = "A"*9
    assert_not @recipe.valid?
  end

  test "description must be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end

  test "description length should not be more than 500" do
    @recipe.description = "A"*501
    assert_not @recipe.valid?
  end

  test "description length should not be less than 20" do
    @recipe.description = "A"*19
    assert_not @recipe.valid?
  end

end