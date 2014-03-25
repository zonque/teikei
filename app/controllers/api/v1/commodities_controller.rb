class Api::V1::CommoditiesController < Api::V1::BaseController
  respond_to :json

  def index
    groups = CommodityGroup.all
    render json: groups.to_json(only: [],
                                methods: [:translated_name],
                                include: {
                                  commodities: {
                                    only: [:id],
                                    methods: [:translated_name],
                                  }
                                })
  end

end
