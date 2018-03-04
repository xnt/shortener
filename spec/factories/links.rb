##
# Defines a set of faked link data to populate the DB, in order
# to better test the controller behaviour
#
FactoryBot.define do

    ##
    # Creates a fake link item
    #
    factory :link do
        original { build_url }
    end

    ##
    # Creates a fake URL for testing purposes
    #
    def build_url do

        # Get fake data
        protocol = ['http', 'https'].sample
        domain = Faker::HarryPotter.house
        tld = ['.com', '.net', '.io', '.org', '.edu'].sample
        path_dir = Faker::DragonBall.character.gsub(' ', '%20')
        path_file = Faker::GameOfThrones.house.gsub(' ', '%20')

        # Build the URL itself
        "#{protocol}://#{domain}#{tld}/#{path_dir}/#{path_file}"
    end

end