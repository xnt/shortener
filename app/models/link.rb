##
# Defines a link model
#
class Link < ApplicationRecord
    validates :shortened, presence: true
    validates :original, presence: true, url: true

    before_create :set_new_shortened

    ##
    # Creates a short, pseudo-unique string
    #
    def self.create_shortened
        rand(36**8).to_s(36)
    end

    def set_new_shortened
        self.shortened = Link::create_shortened
    end

end
