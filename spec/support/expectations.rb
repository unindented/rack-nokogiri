module MiniTest::Assertions

  def assert_has_css(html, css)
    assert ::Nokogiri::HTML(html).css(css).length > 0,
      "Expected HTML to produce results for CSS selector `#{css}`"
  end

  def refute_has_css(html, css)
    refute ::Nokogiri::HTML(html).css(css).length > 0,
      "Expected HTML to produce no results for CSS selector `#{css}`"
  end

  def assert_has_xpath(html, xpath)
    assert ::Nokogiri::HTML(html).xpath(xpath).length > 0,
      "Expected HTML to produce results for XPath selector `#{xpath}`"
  end

  def refute_has_xpath(html, xpath)
    refute ::Nokogiri::HTML(html).xpath(xpath).length > 0,
      "Expected HTML to produce no results for XPath selector `#{xpath}`"
  end

end

module MiniTest::Expectations

  infect_an_assertion :assert_has_css,   :must_have_css,   :reverse
  infect_an_assertion :refute_has_css,   :wont_have_css,   :reverse

  infect_an_assertion :assert_has_xpath, :must_have_xpath, :reverse
  infect_an_assertion :refute_has_xpath, :wont_have_xpath, :reverse

end
