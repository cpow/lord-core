module PropertyManagers
  class CreateService
    attr_accessor :property_manager

    def initialize(property_manager:)
      @property_manager = property_manager
    end

    def handle_callbacks!
      add_company unless property_manager.has_company?
    end

    private

    def add_company
      company = Company.create!(name: property_manager.dummy_company_name)
      property_manager.update_attributes!(company_id: company.id, admin: true)
    end
  end
end
