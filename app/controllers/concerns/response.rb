##
# Response-related routines
#
module Response

    ##
    # Renders a JSON response with an HTTP 200 status
    #
    def json_response(object, status = :ok)
        render json: object, status: status
    end
end