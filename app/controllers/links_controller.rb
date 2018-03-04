##
# Declares links-related route handling routines
#
class LinksController < ApplicationController

    ##
    # Handles +GET+ requests. Uses the request path as the shortened attribute,
    # then redirects to the corresponding URL if found.
    #
    # Possible HTTP codes:
    #
    # [302] Redirection to the appropriate URL
    # [404] That shortened link was not found
    # [500] Service derped
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
    # Handles +POST+ requests. If things went OK, returns a JSON representation of the newly
    # created object (including the assigned shortened URL). 
    #
    # Possible HTTP codes:
    #
    # [200] It went _okay_
    # [415] Something was on the caller's side. Maybe the URL is invalid
    # [500] Service derped
    #
    def create
        # Create
        link = do_create

        # Invalid creation
        status = ( link.valid? ? 200 : 415)
        json_response(link, status)
    end

    private

    ##
    # Permited parameters
    #
    def links_params
        params.permit(:original)
    end

    ##
    # Performs the link creation per se
    #
    def do_create
        link = Link.new
        link.original = links_params[:original]
        link.shortened = Link::create_shortened
        link.subdomain = request.subdomain
        link.save
        link
    end

end
