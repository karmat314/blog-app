require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: "thapkay", password: "password123")
  end

  test "should not save post without title" do
    post = Post.new(body: "Sample content", user: @user)
    assert_not post.save, "Saved the post without a title"
  end

  test "should save valid post" do
    post = Post.new(title: "My First Post", body: "Hello world!", user: @user)
    assert post.save, "Couldn't save a valid post"
  end

  test "should belong to a user" do
    post = Post.new(title: "Another post", body: "Sample body")
    assert_not post.save, "Saved post without a user"
  end
end
