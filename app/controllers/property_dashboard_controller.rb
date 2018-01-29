class PropertyDashboardController < ApplicationController
  # we need a query that gets all events tied to a property. something like:
  # Event.where(eventable: [query.units, query.residencies].flatten)
  def show
  end
end
