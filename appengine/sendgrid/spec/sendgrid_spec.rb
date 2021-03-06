# Copyright 2016 Google, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative "../app.rb"
require "rspec"
require "capybara/rspec"

describe "SendGrid", type: :feature do
  it "can send email" do
    Capybara.app = Sinatra::Application

    visit "/"

    fill_in "recipient", with: "recipient@example.com"
    click_button "Send email"

    # SendGrid::Exception was successully caught and rendered
    expect(page).to have_content "An error occurred"
  end
end
