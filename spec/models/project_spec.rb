require 'rails_helper'

RSpec.describe Project, type: :model do
  
  it "does not allow duplicate project names per user" do
    user = FactoryBot.create(:user)
    FactoryBot.create(:project, name: "Test Project", owner: user)
    
    new_project = FactoryBot.build(:project, name: "Test Project", owner: user)
    
    new_project.valid?
    
    expect(new_project.errors[:name]).to include("has already been taken") 
  end
  
  it "allows two users to share a project name" do
    FactoryBot.create(:project, name: "Test Project")
    project = FactoryBot.create(:project, name: "Test Project")
    
    expect(project).to be_valid
  end
  
  describe "late status" do
    
    it "is late when the due date is past today" do
      project = FactoryBot.build(:project, :due_yesterday)
      expect(project).to be_late
    end
    
    # it "is on time when the due date is today" do
    #   project = FactoryBot.build(:project, due_on: Date.current.in_time_zone)
    #   expect(project).to_not be_late
    # end
    
    # it "is on time when the due date is in the future" do
    #   project = FactoryBot.build(:project, due_on: 1.day.from_now)
    #   expect(project).to_not be_late
    # end
    
    # it "can have many notes" do
    #   project = FactoryBot.create(:project, :with_notes)
    #   expect(project.notes.length).to eq 5
    # end
    
  end
end





