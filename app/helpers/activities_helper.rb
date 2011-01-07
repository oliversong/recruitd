module ActivitiesHelper

  # Given an activity, return a message for the feed for the activity's class.
  def feed_message(activity, recent = false)
    user = activity.user
    case activity_type(activity)
    when "BlogPost"
      post = activity.item
      blog = post.blog
      view_blog = blog_link("#{h user.name}'s blog", blog)
      if recent
        %(new blog post  #{post_link(blog, post)})
      else
        %(#{user_link_with_image(user)} posted
          #{post_link(blog, post)} &mdash; #{view_blog})
      end
    when "Comment"
      parent = activity.item.commentable
      parent_type = parent.class.to_s
      case parent_type
      when "BlogPost"
        post = activity.item.commentable
        blog = post.blog
        if recent
          %(made a comment to #{someones(blog.user, user)} blog post
            #{post_link(blog, post)})
        else
          %(#{user_link_with_image(user)} made a comment to
            #{someones(blog.user, user)} blog post
            #{post_link(blog, post)})
        end
      when "User"
        if recent
          %(commented on #{wall(activity)})
        else
          %(#{user_link_with_image(activity.item.commenter)}
            commented on #{wall(activity)})
        end
      end
    when "Event"
      # TODO: make recent/long versions for this
      event = activity.item.commentable
      commenter = activity.item.commenter
      %(#{user_link_with_image(commenter)} commented on 
        #{someones(event.user, commenter)} event: 
        #{event_link(event.title, event)}.)
    when "Connection"
      if activity.item.contact.admin?
        if recent
          %(joined the system)
        else
          %(#{user_link_with_image(activity.item.user)}
            has joined the system)
        end
      else
        if recent
          %(connected with #{user_link_with_image(activity.item.contact)})
        else
          %(#{user_link_with_image(activity.item.user)} and
            #{user_link_with_image(activity.item.contact)} have connected)
        end
      end
    when "ForumPost"
      post = activity.item
      if recent
        %(new post to forum topic #{topic_link(post.topic)})
      else
        %(#{user_link_with_image(user)} made a post to forum topic
          #{topic_link(post.topic)})
      end
    when "Topic"
      if recent
        %(new discussion topic #{topic_link(activity.item)})
      else
        %(#{user_link_with_image(user)} created the new discussion topic
          #{topic_link(activity.item)})
      end
    when "User"
      if recent
        %(description changed)
      else
        %(#{user_link_with_image(user)}'s description changed)
      end
    when "Gallery"
      if recent
        %(new gallery #{gallery_link(activity.item)})
      else
        %(#{user_link_with_image(user)} added a new gallery
          #{gallery_link(activity.item)})
      end
    when "Photo"
      if recent
        %(added new #{photo_link(activity.item)}
          #{to_gallery_link(activity.item.gallery)})
      else
        %(#{user_link_with_image(user)} added a new
          #{photo_link(activity.item)}
          #{to_gallery_link(activity.item.gallery)})
      end
    when "Event"
      event = activity.item
      %(#{user_link_with_image(user)} has created a new event:
        #{event_link(event.title, event)}.)
    when "EventAttendee"
      event = activity.item.event
      %(#{user_link_with_image(user)} is attending
        #{someones(event.user, user)} event: 
        #{event_link(event.title, event)}.) 
    else
      raise "Invalid activity type #{activity_type(activity).inspect}"
    end
  end
  
  def minifeed_message(activity)
    user = activity.user
    case activity_type(activity)
    when "BlogPost"
      post = activity.item
      blog = post.blog
      %(#{user_link(user)} made a
        #{post_link("new blog post", blog, post)})
    when "Comment"
      parent = activity.item.commentable
      parent_type = parent.class.to_s
      case parent_type
      when "BlogPost"
        post = activity.item.commentable
        blog = post.blog
        %(#{user_link(user)} made a comment on
          #{someones(blog.user, user)} 
          #{post_link("blog post", post.blog, post)})
      when "User"
        %(#{user_link(activity.item.commenter)} commented on 
          #{wall(activity)}.)
      when "Event"
        event = activity.item.commentable
        %(#{user_link(activity.item.commenter)} commented on 
          #{someones(event.user, activity.item.commenter)} #{event_link("event", event)}.)
      end
    when "Connection"
      if activity.item.contact.admin?
        %(#{user_link(user)} has joined the system)
      else
        %(#{user_link(user)} and
          #{user_link(activity.item.contact)} have connected)
      end
    when "ForumPost"
      topic = activity.item.topic
      %(#{user_link(user)} made a
        #{topic_link("forum post", topic)})
    when "Topic"
      %(#{user_link(user)} created a 
        #{topic_link("new discussion topic", activity.item)})
    when "User"
      %(#{user_link(user)}'s description changed)
    when "Gallery"
      %(#{user_link(user)} added a new gallery
        #{gallery_link(activity.item)})
    when "Photo"
      %(#{user_link(user)} added new
        #{photo_link(activity.item)} #{to_gallery_link(activity.item.gallery)})
      %(#{user_link(user)}'s description has changed.)
    when "Event"
      %(#{user_link(user)}'s has created a new
        #{event_link("event", activity.item)}.)
    when "EventAttendee"
      event = activity.item.event
      %(#{user_link(user)} is attending
        #{someones(event.user, user)} #{event_link("event", event)}.)
    else
      raise "Invalid activity type #{activity_type(activity).inspect}"
    end
  end
  
  # Given an activity, return the right icon.
  def feed_icon(activity)
    img = case activity_type(activity)
            when "BlogPost"
              "page_white.png"
            when "Comment"
              parent_type = activity.item.commentable.class.to_s
              case parent_type
              when "BlogPost"
                "comment.png"
              when "Event"
                "comment.png"
              when "User"
                "sound.png"
              end
            when "Connection"
              if activity.item.contact.admin?
                "vcard.png"
              else
                "connect.png"
              end
            when "ForumPost"
              "asterisk_yellow.png"
            when "Topic"
              "note.png"
            when "User"
                "user_edit.png"
            when "Gallery"
              "photos.png"
            when "Photo"
              "photo.png"
            when "Event"
              # TODO: replace with a png icon
              "time.gif"
            when "EventAttendee"
              # TODO: replace with a png icon
              "check.gif"
            else
              raise "Invalid activity type #{activity_type(activity).inspect}"
            end
    image_tag("icons/#{img}", :class => "icon")
  end
  
  def someones(user, commenter, link = true)
    link ? "#{user_link_with_image(user)}'s" : "#{h user.name}'s"
  end
  
  def blog_link(text, blog)
    link_to(text, blog_path(blog))
  end
  
  def post_link(text, blog, post = nil)
    if post.nil?
      post = blog
      blog = text
      text = post.title
    end
    link_to(text, blog_post_path(blog, post))
  end
  
  def topic_link(text, topic = nil)
    if topic.nil?
      topic = text
      text = topic.name
    end
    link_to(text, forum_topic_path(topic.forum, topic))
  end
  
  def gallery_link(text, gallery = nil)
    if gallery.nil?
      gallery = text
      text = gallery.title
    end
    link_to(h(text), gallery_path(gallery))
  end
  
  def to_gallery_link(text = nil, gallery = nil)
    if text.nil?
      ''
    else
      'to the ' + gallery_link(text, gallery) + ' gallery'
    end
  end
  
  def photo_link(text, photo= nil)
    if photo.nil?
      photo = text
      text = "photo"
    end
    link_to(h(text), photo_path(photo))
  end

  def event_link(text, event)
    link_to(text, event_path(event))
  end


  # Return a link to the wall.
  def wall(activity)
    commenter = activity.user
    user = activity.item.commentable
    link_to("#{someones(user, commenter, false)} wall",
            user_path(user, :anchor => "tWall"))
  end
  
  # Only show member photo for certain types of activity
  def posterPhoto(activity)
    shouldShow = case activity_type(activity)
    when "Photo"
      true
    when "Connection"
      true
    else
      false
    end
    if shouldShow
      image_link(activity.user, :image => :thumbnail)
    end
  end
  
  private
  
    # Return the type of activity.
    # We switch on the class.to_s because the class itself is quite long
    # (due to ActiveRecord).
    def activity_type(activity)
      activity.item.class.to_s      
    end
end
