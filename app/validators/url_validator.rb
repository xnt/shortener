require 'uri'

##
# Performs validations to ensure that the attribute is a 
# valid URL
# 
# Arguably, the most convenient mechanism would be doing an
# HTTP call to the URL itself and expecting a 2XX or 3XX. But
# that'd make certain assumptions about the environment itself.
#
class UrlValidator < ActiveModel::EachValidator

    ##
    # Validates that the attribute is being assigned a valid URL
    #
    # As it is now, the method tries to use +URI::Parser.parse+ . If
    # needed, one could also use a regular expression (there is one in URI, with
    # some faults, and there are tons on the internet), or even try to perform
    # a request.
    #
    # Assuming an error-free parse, then the scheme is expected to be either
    # +HTTP+ or +HTTPS+. This forces us to only accept full URIs, including
    # protocol... But it's a relatively fast way of validating it
    # 
    # === Arguments
    #
    # +record+ The record whose attribute is being modified
    # +attribute+ The attribute that's being modified
    # +value+ The value that's being passed to that attribute
    #
    def validate_each(record, attribute, value)
        is_valid = url_valid?(value)

        unless is_valid
            record.errors[attribute] << (options[:message] || "is not a valid URL (#{value})")
        end
    end

    private

        ##
        # Internal method that performs the proper validation
        #
        def url_valid?(url)
            uri = URI.parse(url) rescue false
            uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
        end
end