class LinksController < ApplicationController

    ##
    # +GET+
    #
    def show
        ActionController::redirect_to @link.original
    end

    ##
    # +POST+
    #
    def create
        #links_params.shortened = Link::create_shortened
        @link = Link.create(links_params)
        json_response(@link)
    end

    private

    def links_params
        params.permit(:original, :shortened)
    end

    def set_link
        @link = Link.find(params[:shortened])
    end
end
