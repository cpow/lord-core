require 'rails_helper'

describe Residency::CreateFromProperty do
  describe '#new' do
    it 'should initialize with property and residency' do
      residency = build_stubbed(:residency)
      creator = described_class.new(property: build_stubbed(:property), residency: residency)
      expect(creator).to be_truthy
    end
  end

  describe '#save' do
    context 'with correct residency' do
      it 'should create a new unactivated user' do
        prop = create(:property)
        unit = create(:unit, property: prop)
        email = 'hello@kitty.com'
        residency = prop.residencies.new(unit: unit, user_email: email)
        creator = described_class.new(property: prop, residency: residency)
        expect { creator.save }.to change(User, :count).by(1)
      end

      it 'should create a new residency with all join peices together' do
        prop = create(:property)
        unit = create(:unit, property: prop)
        email = 'hello@kitty.com'
        residency = prop.residencies.new(unit: unit, user_email: email)
        creator = described_class.new(property: prop, residency: residency)
        creator.save

        expect(creator.residency).to be_valid
      end

      it 'should send an invite email to user' do
        prop = create(:property)
        unit = create(:unit, property: prop)
        email = 'hello@kitty.com'
        residency = prop.residencies.new(unit: unit, user_email: email)
        creator = described_class.new(property: prop, residency: residency)

        expect do
          creator.save
        end.to have_enqueued_job(ActionMailer::DeliveryJob)
      end
    end

    context 'with errors' do
      it 'should return residency object for error display' do
        prop = create(:property)
        res = Residency.new
        creator = described_class.new(property: prop, residency: res)
        expect(creator.save).to be_falsey
        expect(creator.residency.errors).to_not be_nil
      end
    end
  end
end
