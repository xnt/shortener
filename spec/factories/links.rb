require 'cgi'

##
# Creates a fake URL for testing purposes
#
def build_url
    # Get fake data
    protocol = ['http', 'https'].sample
    domain = CGI.escape(Faker::HarryPotter.house)
    tld = ['.com', '.net', '.io', '.org', '.edu'].sample
    path_dir = CGI.escape(Faker::DragonBall.character)
    path_file = CGI.escape(Faker::GameOfThrones.house)

    # Build the URL itself
    "#{protocol}://#{domain}#{tld}/#{path_dir}/#{path_file}"
end

##
# Creates a random short link
def random_short_link
    CGI.escape(Faker::Zelda.character)[0..6]
end

##
# Defines a set of faked link data, in order to better test the
# controller/API behaviour
#
FactoryBot.define do

    ##
    # Creates a fake link item
    #
    factory :link do
        original { build_url }
        shortened { random_short_link }
        subdomain { 't1' }
    end

end