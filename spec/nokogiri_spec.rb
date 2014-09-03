require File.expand_path('../spec_helper', __FILE__)

describe Rack::Nokogiri do

  let(:app) do
    create_app(status, headers, content, opts) do |nodes|
      nodes.wrap('<div class="greeting"></div>')
    end
  end

  before do
    get '/'
  end

  describe 'with a content-type other than `text/html`' do

    let(:status) { 200 }
    let(:headers) do
      {
        'Content-Type'   => 'text/plain',
        'Content-Length' => content.length.to_s
      }
    end

    let(:content) { 'foobar' }
    let(:opts) { {} }

    it 'leaves the status untouched' do
      last_response.status.must_equal status
    end

    it 'leaves the headers untouched' do
      last_response.headers.must_equal headers
    end

    it 'leaves the content untouched' do
      last_response.body.must_equal content
    end

  end

  describe 'with a content-type of `text/html`' do

    let(:status) { 200 }
    let(:headers) do
      {
        'Content-Type'   => 'text/html',
        'Content-Length' => content.length.to_s
      }
    end

    let(:content) do
      <<-eos
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8" />
          <title>Some HTML</title>
        </head>

        <body>
          <p class="hi">Hi!</p>
          <p class="bye">Bye!</p>
        </body>
      </html>
      eos
    end

    describe 'with a CSS selector' do
      let(:opts) { { css: 'p.hi' } }

      it 'leaves the status untouched' do
        last_response.status.must_equal status
      end

      it 'updates the headers with the new `Content-Length`' do
        last_response.headers.wont_equal headers
      end

      it 'executes the block on the results of the selector' do
        last_response.body.must_have_css ".greeting .hi"
        last_response.body.wont_have_css ".greeting .bye"
      end
    end

    describe 'with a XPath selector' do
      let(:opts) { { xpath: "//p[@class='hi']" } }

      it 'leaves the status untouched' do
        last_response.status.must_equal status
      end

      it 'updates the headers with the new `Content-Length`' do
        last_response.headers.wont_equal headers
      end

      it 'executes the block on the results of the selector' do
        last_response.body.must_have_xpath "//div[@class='greeting']/p[@class='hi']"
        last_response.body.wont_have_xpath "//div[@class='greeting']/p[@class='bye']"
      end
    end

  end

end
