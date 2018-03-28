require 'rails_helper'

RSpec.describe NotificationEmailReminderWorker, type: :worker do
  describe '.perform' do
    it 'should mail to all users' do
      event = create(:event)
      user = create(:user)

      allow_any_instance_of(Notifications::Unread).to\
        receive(:users).and_return([user])
      allow_any_instance_of(Notifications::Unread).to\
        receive(:managers).and_return(nil)

      expect do
        described_class.new.perform(event.id)
      end.to have_enqueued_job.on_queue('mailers')
    end

    it 'should mail to all property managers' do
      event = create(:event)
      manager = create(:property_manager)

      allow_any_instance_of(Notifications::Unread).to\
        receive(:users).and_return(nil)
      allow_any_instance_of(Notifications::Unread).to\
        receive(:managers).and_return([manager])

      expect do
        described_class.new.perform(event.id)
      end.to have_enqueued_job.on_queue('mailers')
    end
  end
end
