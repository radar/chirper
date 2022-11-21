module Chirper
  RSpec.describe ActivityPub::Processor do
    include Deps[actor_repo: "persistence.repos.actor"]

    let(:published) { "2022-11-20T19:43:18Z" }
    let(:activity) do
      ActivityPub::Follow.new(
        "type": "Follow",
        "actor": "https://ruby.social/users/Ryanbigg",
        "object": "https://ruby.social/users/matz",
      )
    end

    context "when object exists as an actor" do
      before do
        actor_repo.create(uri: "https://ruby.social/users/matz")
      end

      it "loads a Follow activity into the DB" do
        result = subject.handle(activity)
        expect(result).to be_success

        follow = result.success
        expect(follow).to be_a(Chirper::Follow)

        expect(follow.follower.uri).to eq("https://ruby.social/users/Ryanbigg")
        expect(follow.followee.uri).to eq("https://ruby.social/users/matz")
      end
    end

    context "when object does not exist as an actor" do
      it "returns a failure" do
        result = subject.handle(activity)
        expect(result).to be_failure

        error = result.failure
        expect(error).to eq("Could not find actor for uri=https://ruby.social/users/matz")
      end
    end
  end
end
