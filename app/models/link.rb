##
# Defines a link model
#
class Link < ApplicationRecord
    validates :shortened, presence: true
    validates :original, presence: true, url: true
end
