require 'rails_helper'

RSpec.describe MuscleTarget, type: :model do
  context "associations" do
    it { should belong_to(:muscle_group) }
    it { should belong_to(:exercise) }
  end
end
