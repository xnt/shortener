##
# Provides helper routines for the request spec testing
#
module RequestSpecHelper
    ##
    # Parse JSON response to ruby hash
    #
    def json
      JSON.parse(response.body)
    end
end