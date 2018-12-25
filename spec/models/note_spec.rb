require 'rails_helper'

RSpec.describe Note, type: :model do
  
  it "is valid with a user, project and message" do
    note = FactoryBot.build(:note)
    expect(note).to be_valid
  end
  
  it "is invalid without a message" do
    note = FactoryBot.build(:note, message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end
  
  describe "search message for a term" do
    
    context "when a match is found" do
      
      before do
        @note1 = FactoryBot.create(:note, message: "This is first message.")
        @note2 = FactoryBot.create(:note, message: "This is second message.")
        @note3 = FactoryBot.create(:note, message: "First, preheat oven.")
      end
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
        expect(Note.search("first")).to_not include(@note2)
      end
    end
    
    context "when no match is found" do
      it "returns an empty collection" do
        expect(Note.search("third")).to be_empty
      end
    end
  end
  
end











