##
# Defines a link model
#
class Link < ApplicationRecord
    validates :shortened, presence: true
    validates :original, presence: true, url: true
    ##
    # Creates a short, pseudo-unique string
    #
    def self.create_shortened
        rand(36**8).to_s(36)
    end

    def self.get_original
        self.original
    end

end
