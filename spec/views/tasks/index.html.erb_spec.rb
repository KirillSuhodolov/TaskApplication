require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(:tasks, [
      stub_model(Task,
        :title => "Title",
        :body_task => "MyText"
      ),
      stub_model(Task,
        :title => "Title",
        :body_task => "MyText"
      )
    ])
  end


end
