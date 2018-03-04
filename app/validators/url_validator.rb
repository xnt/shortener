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
    # Reusable URI parser among different instances
    #
    @@parser = URI::Parser.new

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
        puts "howdy #{value}"
        is_valid = begin
            scheme = @@parser.parse(value).scheme
            scheme =~ /^https?$/
        rescue 
            false
        end

        unless is_valid
            record.errors[attribute] << (options[:message] || "is not a valid URL")
        end
    end
end