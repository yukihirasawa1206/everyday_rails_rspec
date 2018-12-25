require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "tester1@example.com",
      password: "password"
    )
    user.projects.create(name: "Test Project")
    
    new_project = user.projects.build(name: "Test Project")
    
    new_project.valid?
    
    expect(new_project.errors[:name]).to include("has already been taken") 
  end
  
  it "allows two users to share a project name" do
    user1 = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "tester1@example.com",
      password: "password"
      )
    user2 = User.create(
      first_name: "Yuki",
      last_name: "Tester",
      email: "tester2@example.com",
      password: "password"
      )
    user1.projects.create(name: "Test Project")
    project = user2.projects.build(name: "Test Project")
    
    expect(project).to be_valid
  end
end
