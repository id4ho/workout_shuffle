require 'rails_helper'

RSpec.describe Exercise, type: :model do
  context "associations" do
    it { should have_many(:muscle_targets) }
    it { should have_many(:muscle_groups) }
    it { should have_one(:primary_target).conditions(primary: true) }
    it do
      should have_one(:primary_muscle_group)
        .through(:primary_target)
        .source(:muscle_group)
    end
  end

end
