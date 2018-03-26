module Api::V1
  class EventReadsController < ApplicationController
    def create
      create_params = event_read_params
      user_object = create_params[:reader_type]
                    .constantize
                    .find(create_params[:reader_id])

      if user_object == current_user || current_property_manager
        event = Event.find(params[:event_id])
        event_reads = event.event_reads.where(reader: user_object, event: event)
        event_read = if event_reads.present?
                       event_reads.first
                     else
                      event.event_reads.create!(event_read_params)
                     end

        return render json: event_read, status: :ok
      end

      render json: {error: 'invalid user'}, status: :forbidden
    end

    private

    def event_read_params
      params.require(:event_read).permit(:reader_id, :reader_type, :event_id)
    end
  end
end
