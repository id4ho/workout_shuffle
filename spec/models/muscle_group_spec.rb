require 'rails_helper'

RSpec.describe MuscleGroup, type: :model do
  context "associations" do
    it { should have_many(:muscle_targets) }
    it { should have_many(:exercises).through(:muscle_targets) }
  end
end
