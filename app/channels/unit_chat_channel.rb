class UnitChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from channel_name
  end

  def receive(data)
    message = create_message(data)
    ActionCable.server.broadcast(channel_name, json_for_message(message))
  end

  private

  def json_for_message(message)
    Api::V1::UnitMessagesController.render(
      'show',
      assigns: { message: message })
  end

  def create_message(data)
    message = Message.create!(
      unit_id: params[:unitId],
      body: data['body'],
      messageable_id: data['messageableId'],
      messageable_type: data['messageableType']
    )

    property = message.unit.property

    Event.create!(eventable: message,
                  createable: message.messageable,
                  event_type: Event::EVENT_CREATED,
                  property: property,
                 )

    message
  end

  def channel_name
    @channel_name ||= "unit_channel_#{params[:unitId]}"
  end
end
