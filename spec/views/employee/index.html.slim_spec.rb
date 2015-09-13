require 'rails_helper'

describe 'employee/index.html.slim' do
  before  { render }
  subject { rendered }

  it "will have an important element" do
    is_expected.to have_selector ".filter__lokasi"
    is_expected.to have_selector ".filter__submit"
  end
end
