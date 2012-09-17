require 'spec_helper'

describe "Tasks" do
  describe "GET /tasks" do
    it "task helper" do
      get tasks_path
      response.status.should be(302)
    end
  end
end
