# frozen_string_literal: true

require "test_helper"

class LikesHelperTest < ActionView::TestCase
  include ApplicationHelper

  attr_accessor :user, :topic, :reply

  setup do
    @user = create :user
    @topic = create :topic
    @reply = create :reply
  end

  test "should run with nil param" do
    assert_equal "", likeable_tag(nil)
  end

  test "should result when logined user liked" do
      sign_in user
      user.like_topic_ids = [topic.id]
      assert_equal %(<a title="取消赞" data-count="0" data-state="active" data-type="Topic" data-id="1" class="likeable active" href="#"><i class='fa fa-heart'></i> <span></span></a>), likeable_tag(topic)

      topic.likes_count = 3
      assert_equal %(<a title="取消赞" data-count="3" data-state="active" data-type="Topic" data-id="1" class="likeable active" href="#"><i class='fa fa-heart'></i> <span>3 个赞</span></a>), likeable_tag(topic)
  end

  test "should result when unlogin user" do
    assert_equal %(<a title="赞" data-count="0" data-state="deactive" data-type="Topic" data-id="1" class="likeable deactive" href="#"><i class='fa fa-heart'></i> <span></span></a>), likeable_tag(topic)
  end

  test "should result with no_cache params" do
    str = %(<a title="赞" data-count="0" data-state="deactive" data-type="Topic" data-id="1" class="likeable deactive" href="#"><i class='fa fa-heart'></i> <span></span></a>)
    sign_in user
    assert_equal str, likeable_tag(topic, cache: true)
  end

  test "should allow addition class" do
    sign_in user
    assert_equal %(<a title="赞" data-count="0" data-state="deactive" data-type="Reply" data-id="1" class="likeable deactive btn btn-default" href="#"><i class='fa fa-heart'></i> <span></span></a>), likeable_tag(reply, class: "btn btn-default")
  end
end
