Given /^that recipe has a direction$/ do
  @number_of_directions_in_database_before = Direction.count

  @direction = @recipe.directions.create!(title: "Mix", text: "Do some stuff", ingredient_entries: [@recipe.ingredient_entries[0]])
  @recipe.add_result_for @direction

  @direction.result.should_not eq nil

  Recipe.count.should eq(@number_of_directions_in_database_before + 1)
end

When /^I click the delete button next to the direction$/ do
  page.should have_content("Do some stuff")
  popup.confirm{ click_link "delete-direction" }
end

Then /^I should see the direction has been removed$/ do
  page.should_not have_content("Do some stuff")

  Direction.count.should eq(@number_of_directions_in_database_before)
end

When /^I enter valid recipe directions$/ do
  check "direction_ingredient_entries_0"
  fill_in "direction_title",  with: "Mix all"
  fill_in "direction_text",  with: "Mix all ingredients together with blender"
end

When /^I click the add new direction button$/ do
  click_button "Add New Direction"
end

When /^I click the add direction button$/ do
  click_button "Add Direction"
end

Then /^I should not see ingredients already used$/ do
  page.should have_content(@recipe.directions.find(@direction).text)

  @recipe.ingredient_entries.each do |entry|
    if (entry.direction_id == @direction.id)
      page.should_not have_selector('label', text: entry.to_s)
    else
      page.should have_selector('label', text: entry.to_s)
    end
  end
end

Then /^I should see the direction$/ do
  page.should have_content(@direction.title)
end

Then /^I should see the direction available for use as an ingredient$/ do
  page.should have_selector('label', text: @direction.result.to_s)
end

Then /^I should not see the direction text$/ do
  page.should_not have_selector('div', text: @direction.text)
end

When /^I click the direction title$/ do
  click_link @direction.title
end

Then /^I should see the direction text$/ do
  page.should have_content(@direction.text)
end