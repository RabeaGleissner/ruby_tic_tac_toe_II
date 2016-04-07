require 'spec_helper'
require_relative '../lib/views/view_helper'

class ViewHelperWrapper
  include ViewHelper
end

describe ViewHelperWrapper do
  it "converts a group of words into kebab case" do
    view_helper = ViewHelperWrapper.new
    expect(view_helper.convert_to_kebab_case("Human vs Human")).to eq "human-vs-human"
  end
end
