require 'rails_helper'

RSpec.feature "Projects", type: :feature do

	scenario "user creates a new project" do
		user = FactoryBot.create(:user)

		sign_in user
		visit root_path
		expect{
			click_link "New Project"
			fill_in "Name", with: "Test Project"
			fill_in "Description", with: "Trying out Capybara"
			click_button "Create Project"
			expect(page).to have_content "Project was successfully created"
			expect(page).to have_content "Test Project"
			expect(page).to have_content "Owner: #{user.name}"
			}.to change(user.projects, :count).by(1)
	end

	scenario "user completes a project" do
		user = FactoryBot.create(:user)
		project = FactoryBot.create(:project, owner: user)
		login_as user, scope: :user

		visit project_path(project)
		expect(page).to have_button "Complete"
		click_button "Complete"
		expect(project.reload.completed?).to be true
		expect(page).to have_content "Congratulations, this project is complete!"
		expect(page).to have_content "Completed"
	end

end
