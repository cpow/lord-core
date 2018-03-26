require 'rails_helper'

describe Api::V1::EventReadsController do
  describe '#create' do
    context 'when currently signed in as the user creating the read event' do
      it 'shoud create the event read with information' do
        user = create(:user)
        event = create(:event)
        sign_in(user)

        params = {
          event_id: event.id,
          event_read: {
            reader_type: 'User',
            reader_id: user.id
          }
        }

        expect do
          post :create, params: params
        end.to change(EventRead, :count).by(1)
      end
    end

    context 'when not signed in' do
      it 'should respond forbidden' do
        user = create(:user)
        event = create(:event)

        params = {
          event_id: event.id,
          event_read: {
            reader_type: 'User',
            reader_id: user.id
          }
        }

        post :create, params: params

        expect(response.code).to eq('403')
      end
    end
  end
end
