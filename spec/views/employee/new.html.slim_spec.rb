require 'rails_helper'

describe 'employee/new.html.slim' do
  before  { render }
  subject { rendered }

  it "will have an important element" do
    is_expected.to have_selector ".create__nama"
    is_expected.to have_selector ".create__lokasi"
    is_expected.to have_selector ".create__submit"
  end
end
