module Chirper
  RSpec.describe ActivityPub::Processor do

    let(:published) { "2022-11-20T19:43:18Z" }
    let(:activity) do
      ActivityPub::Follow.new(
        "type": "Follow",
        "actor": "https://ruby.social/users/Ryanbigg",
        "object": "https://ruby.social/users/matz",
      )
    end

    it "loads a Follow activity into the DB" do
      follow = subject.handle(activity)
      expect(follow).to be_a(Chirper::Follow)


      expect(follow.follower.uri).to eq("https://ruby.social/users/Ryanbigg")
      expect(follow.followee.uri).to eq("https://ruby.social/users/matz")
    end
  end
end
