module ResidenciesHelper
  def units_available(property_id)
    units = Unit.where(property_id: property_id)
    units.map { |u| [u.name, u.id.to_s] }
  end
end
