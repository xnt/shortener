class LinksController < ApplicationController

    ##
    # +GET+
    #
    def show

        path = request.env['PATH_INFO']
        # Remove slash
        path = path[1..-1]
        link = Link.find_by(shortened: path)

        # Not found
        unless link
            render status: 404
            return
        end

        # Redirect
        redirect_to link.original
    end

    ##
    # +POST+
    #
    def create

        status = 200

        # Create
        link = Link.new
        link.original = links_params[:original]
        link.shortened = Link::create_shortened
        link.subdomain = request.subdomain
        link.save

        # Invalid creation
        unless link.valid? 
            status = 415
        end

        json_response(link, status)
    end

    private

    def links_params
        params.permit(:original, :shortened)
    end

end
