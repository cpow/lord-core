require 'rails_helper'

RSpec.describe Properties::Units::ResidenciesController do
  describe '#new' do
    context 'without any units' do
      it 'should redirect user with flash message' do
        property = create(:property)
      end
    end
  end
end
