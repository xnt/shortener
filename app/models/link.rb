##
# Defines a link model
#
class Link < ApplicationRecord
    validates :shortened, presence: true
    validates :original, presence: true, url: true

    ##
    # Creates a short, pseudo-unique string. If for any
    # reason the string is not 8 characters long (rare, but
    # I've seen it happening), then underscores are appended
    #
    def self.create_shortened
        rand(36**8).to_s(36).rjust(8, '_')
    end

    ##
    # Exposes the +original+ property
    #
    def self.get_original
        self.original
    end

end
