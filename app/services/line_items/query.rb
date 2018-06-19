module LineItems
  class Query
    def initialize(params:, company:)
      @params = params
      @company = company
    end

    def search
      LineItem.search(
        '*',
        where: filter_params,
        page: params[:page],
        per_page: 10,
        order: {
          created_at: {
            order: 'desc'
          }
        }
      )
    end

    private

    attr_reader :company, :params

    def filter_params
      base = { company_id: company.id }

      if params[:itemable_type].present?
        base[:itemable_type] = params[:itemable_type]
      end

      if params[:start_date].present? && params[:end_date].present?
        base[:created_on] = \
          { gte: params[:start_date], lte: params[:end_date] }
      end

      base
    end
  end
end
