require_relative '../lib/mod_manager'

TEST_SPT_DIR = "fake_server/"
describe SPTModManager do
  it "should detect the server's spt version" do
    mm = SPTModManager.new(TEST_SPT_DIR)
    expect(mm.spt_version).to eq("3.11.3")
  end
end
