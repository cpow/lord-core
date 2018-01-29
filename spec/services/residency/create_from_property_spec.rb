require 'rails_helper'

describe Residency::CreateFromProperty do
  describe '#new' do
    it 'should initialize with property and residency' do
      residency = build_stubbed(:residency)
      creator = described_class.new(property: build_stubbed(:property),
                                    residency: residency,
                                    manager: create(:property_manager))
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
        creator = described_class.new(property: prop,
                                      residency: residency,
                                      manager: create(:property_manager))
        expect { creator.save }.to change(User, :count).by(1)
      end

      it 'should create a new residency with all join peices together' do
        prop = create(:property)
        unit = create(:unit, property: prop)
        email = 'hello@kitty.com'
        residency = prop.residencies.new(unit: unit, user_email: email)
        creator = described_class.new(property: prop,
                                      residency: residency,
                                      manager: create(:property_manager))

        expect(creator.save).to eq(Residency::SUCCESS)
        expect(creator.residency).to be_valid
      end

      it 'should make a new event upon successful creation' do
        prop = create(:property)
        unit = create(:unit, property: prop)
        email = 'hello@kitty.com'
        residency = prop.residencies.new(unit: unit, user_email: email)
        creator = described_class.new(property: prop,
                                      residency: residency,
                                      manager: create(:property_manager))

        expect(creator.save).to eq(Residency::SUCCESS)
        expect(creator.residency.events.count).to eq(1)
      end

      it 'should send an invite email to user' do
        prop = create(:property)
        unit = create(:unit, property: prop)
        email = 'hello@kitty.com'
        residency = prop.residencies.new(unit: unit, user_email: email)
        creator = described_class.new(property: prop,
                                      residency: residency,
                                      manager: create(:property_manager))

        expect do
          creator.save
        end.to have_enqueued_job(ActionMailer::DeliveryJob)
      end

      it 'will not save a new residency if the user/residency already exists' do
        prop = create(:property)
        unit = create(:unit, property: prop)
        email = 'hello@kitty.com'
        user = create(:user, email: email)

        create(:residency, user: user, property: unit.property, unit: unit)

        expect(Residency.count).to eq(1)

        residency = prop.residencies.new(unit: unit, user_email: email)
        creator = described_class.new(property: prop,
                                      residency: residency,
                                      manager: create(:property_manager))

        expect(creator.save).to eq(Residency::EXISTS)
        expect(Residency.count).to eq(1)
      end
    end

    context 'with errors' do
      it 'should return residency object for error display' do
        prop = create(:property)
        res = Residency.new
        creator = described_class.new(property: prop,
                                      residency: res,
                                      manager: create(:property_manager))
        expect(creator.save).to eq(Residency::ERROR)
        expect(creator.residency.errors).to_not be_nil
      end
    end
  end
end
