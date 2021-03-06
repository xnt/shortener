require 'rails_helper'

##
# Spec for the links API
#
RSpec.describe 'Links API', type: :request do
    
    before do
        Apartment::Tenant.switch! 't1'
    end

    # Create fake data
    let!(:links) { create_list(:link, 10) }

    # Get the first fake item and use it to test
    let(:sample_link) { links.first }

    # Get the first fake shortened term
    let(:sample_shortened) { links.first.shortened }

    ##
    # Spec for the POST endpoint
    #
    describe 'POST /links' do

        let(:valid_attributes) { { original: 'http://facebook.com' } }
        let(:invalid_url) { { original: "huehuehue" } }
        
        context 'when the request is valid' do
            before { post '/links', params: valid_attributes }
            
            it 'creates a shortened link entry' do
                expect(json['original']).to eq('http://facebook.com')
            end

            it 'returns HTTP 200' do
                expect(response).to have_http_status(200)
            end

            it 'has a shortened link' do
                expect(json['shortened']).not_to be_empty
            end
        end

        context 'when the request is missing the url param' do
            before { post '/links' }

            it 'returns HTTP 415' do
                expect(response).to have_http_status(415)
            end
        end

        context 'when the request has an invalid url' do
            before { post '/links', params: invalid_url }

            it 'returns HTTP 415' do
                expect(response).to have_http_status(415)
            end

        end
    end

    ##
    # Spec for the GET endpoint
    #
    describe '/GET links' do
        before { 
            # This gem is a torture
            Apartment::Tenant.switch! 't1'
            host! 't1.shortener.test' 
            get "/#{sample_shortened}" 
        }

        context 'when the shortened param is valid' do
            it 'redirects to the url' do
                expect(response).to redirect_to(sample_link.original)
            end

            it 'returns HTTP 302' do
                expect(response).to have_http_status(302)
            end
        end

        context 'when the shortened param is unknown' do
            let(:sample_shortened) { 0 }
            
            it 'returns HTTP 404' do
                expect(response).to have_http_status(404)
            end
        end
    end
end