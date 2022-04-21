require "application_system_test_case"

class HitsTest < ApplicationSystemTestCase
  setup do
    @hit = hits(:one)
  end

  test "visiting the index" do
    visit hits_url
    assert_selector "h1", text: "Hits"
  end

  test "should create hit" do
    visit hits_url
    click_on "New hit"

    fill_in "Language", with: @hit.language
    fill_in "Project", with: @hit.project
    fill_in "Timestamp", with: @hit.timestamp
    click_on "Create Hit"

    assert_text "Hit was successfully created"
    click_on "Back"
  end

  test "should update Hit" do
    visit hit_url(@hit)
    click_on "Edit this hit", match: :first

    fill_in "Language", with: @hit.language
    fill_in "Project", with: @hit.project
    fill_in "Timestamp", with: @hit.timestamp
    click_on "Update Hit"

    assert_text "Hit was successfully updated"
    click_on "Back"
  end

  test "should destroy Hit" do
    visit hit_url(@hit)
    click_on "Destroy this hit", match: :first

    assert_text "Hit was successfully destroyed"
  end
end
